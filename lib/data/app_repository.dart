import 'dart:async';

import 'package:sprouter/data/local/app_local_repo.dart';
import 'package:sprouter/data/local/local_repo.dart';
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/model/slack/profile.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';
import 'package:sprouter/data/model/slack/user_list.dart';
import 'package:sprouter/data/remote/api_error.dart';
import 'package:sprouter/data/remote/app_remote_repo.dart';
import 'package:sprouter/data/remote/remote_repo.dart';
import 'package:sprouter/data/repository.dart';
import 'package:sprouter/env_config.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';
import 'package:sprouter/util/utils.dart';

class AppRepository implements Repository {
  static const String redirectUrl = AppRemoteRepo.slackRedirectUrl;
  static const String _conversationType_im = "im";
  static String clientId = AppRemoteRepo.slackClientId;
  static String jibbleUserId = EnvConfig.jibbleUserId;
  static String _lunchChannel = EnvConfig.lunchChannelId;

  static final AppRepository _repo = AppRepository._internal();

  static AppRepository get repo => _repo;

  RemoteRepo _remoteRepo;
  LocalRepo _localRepo;

  List<Members> _members;
  User _currentUser;
  String _userId;

  AppRepository._internal() {
    _remoteRepo = AppRemoteRepo.repo;
    _localRepo = AppLocalRepo.repo;
  }

  @override
  Future<User> getUser() {
    return _remoteRepo.getUserIdentity().then((identity) => identity?.user);
  }

  @override
  Future<String> getTokenCache() {
    return _localRepo.loadSlackToken();
  }

  @override
  Future<String> fetchSlackToken(String code) async {
    String token = (await _remoteRepo.getSlackOauthToken(code))?.accessToken;
    _remoteRepo.setSlackTokenCache(token);
    await _localRepo.saveSlackToken(token);
    _currentUser =
        (await _remoteRepo.getUserIdentity(accessToken: token))?.user;
    if (_currentUser != null) {
      await _localRepo.saveUserData(_currentUser.id, _currentUser.name, token);
    }
    return token;
  }

  @override
  Future<List<Message>> fetchLatestDrinkMessages() async {
    const String orderBroadcastKeyword = "今天點的是";

    DateTime now = DateTime.now();
    int midnightMilliseconds =
        now.subtract(Duration(days: 1, hours: now.hour)).millisecondsSinceEpoch;

    Message thread = await _remoteRepo
        .fetchConversationHistory(
      _lunchChannel,
      oldest: (midnightMilliseconds / 1000).floor().toString(),
    ) //1. 抓出 Lunch channel "一天內" 的前 N 筆 message
        .then((conversationList) async {
      if (!conversationList.ok) {
        throw ApiError(conversationList.error);
      }
      List<Message> messages = conversationList.messages.toList();
      //2. 用關鍵字 parse 出"最新"廣播訊息的 message
      Message orderBroadcastMessage = messages.firstWhere(
          (message) => message.text.contains(orderBroadcastKeyword),
          orElse: () => null);
      if (orderBroadcastMessage == null) {
        return null;
      }
      //3. 找出店家名稱
      String shopName = orderBroadcastMessage.text.split("：")[1];
      //4. 用店家名稱 parse 出"最新"點單 thread 的 message
      Message drinkMessage = messages.firstWhere((message) {
        File parsedFile = message.parseFile;
        if (parsedFile == null) {
          return false; //點單 thread 的 (菜單圖片) 必定在 files 或 attachment -> files，先過濾一層
        }
        return parsedFile.title.contains(shopName);
      }, orElse: () => null);
      if (!Utils.isStringEmpty(shopName) && drinkMessage != null) {
        await _localRepo.addShopToDB(shopName, drinkMessage?.ts); //保存店家資料到DB
      }
      return drinkMessage;
    });
    if (thread == null) {
      return [];
    }

    String shopName = thread.getShopName;
    String ts = thread?.ts;

    //5. 抓 Slack team 中所有成員資料
    Future<List<Members>> getMembersFuture =
        _members == null || _members.isEmpty
            ? _remoteRepo.getTeamMemberProfile().then((response) => response
                ?.members
                ?.where((member) => !member.isBot && !member.deleted)
                ?.toList())
            : Future.value(_members);

    //6. 抓 Database 中有儲存的 order
    Future<List<String>> getOrderTsListFuture =
        _localRepo.getOrderTsList(shopName, ts);

    //7. 抓 Database 中的最愛飲料
    _userId ??= await _localRepo.loadUserId();
    Future<String> getFavoriteDrinkOrderTsFuture = _localRepo
        .getFavoriteDrinkId(_userId, shopName)
        .then((drinkId) => drinkId == null || drinkId == 0
            ? null
            : _localRepo.getOrderTs(drinkId: drinkId));

    //8. 用 點單 thread 的 ts 抓出其底下所有 reply
    Future<List<Message>> getOrderRepliesFuture = _remoteRepo
        .fetchMessageReplies(_lunchChannel, ts)
        .then((drinkThread) => drinkThread.messages.toList());

    //9. 結合會員列表、reply 資料和 database 資料, 最後回傳加料過的 reply[]
    return Future.wait([
      getMembersFuture,
      getOrderTsListFuture,
      getFavoriteDrinkOrderTsFuture,
      getOrderRepliesFuture
    ]).then((results) async {
      if (results[0] is List<Members>) {
        _members ??= results[0];
      }
      List<String> orderTsList;
      if (results[1] is List<String>) {
        orderTsList = results[1];
      }
      String favoriteDrinkOrderTs;
      if (results[2] is String) {
        favoriteDrinkOrderTs = results[2];
      }

      orderTsList ??= List<String>();
      if (!(results[3] is List<Message>)) {
        return [];
      }

      List<Message> drinkMessages = results[3];
      List<Message> zippedMessages = [];
      for (Message message in drinkMessages) {
        int memberIndex =
            _members?.indexWhere((member) => member.id == message.user);
        int orderTsIndex =
            orderTsList?.indexWhere((orderTs) => orderTs == message.ts);
        Message zippedMessage = Message((b) {
          b.replace(message);
          b.userProfile = memberIndex == -1 ? null : ProfileBuilder()
            ..replace(_members[memberIndex]?.profile);
          b.isAddedBySprouter = orderTsIndex != -1 && _userId == message.user;
          b.isFavoriteDrink = favoriteDrinkOrderTs != null &&
              favoriteDrinkOrderTs == message.ts;
        });
        zippedMessages.add(zippedMessage);
      }
      return zippedMessages;
    });
  }

  @override
  Future<int> orderDrink(String shopName, String threadTs, Drink drink,
      {String orderTs}) async {
    String completeDrinkName = drink?.completeDrinkName;
    PostMessageResponse response = Utils.isStringEmpty(orderTs)
        ? await _remoteRepo.postMessage(_lunchChannel, completeDrinkName,
            ts: threadTs)
        : await _remoteRepo.updateMessage(
            _lunchChannel, orderTs, completeDrinkName);
    int drinkId;
    if (response != null && response.ok) {
      _userId ??= await _localRepo.loadUserId();
      drinkId = await _localRepo.addDrinkOrderToDB(
          _userId, shopName, threadTs, orderTs ?? response.ts, drink);
    }
    return drinkId;
  }

  @override
  Future<Drink> getLocalDrinkData(
      {int drinkId, String shopName, String threadTs, String orderTs}) async {
    Map<String, dynamic> data = await _localRepo.getLocalDrinkData(
        drinkId: drinkId,
        shopName: shopName,
        threadTs: threadTs,
        orderTs: orderTs);
    return Drink.fromMap(data);
  }

  @override
  Future<PostMessageResponse> deleteDrinkOrder(
      String shopName, String threadTs, String orderTs) async {
    PostMessageResponse response =
        await _remoteRepo.deleteMessage(_lunchChannel, orderTs);
    if (response != null && response.ok) {
      _userId ??= await _localRepo.loadUserId();
      await _localRepo.deleteDrinkOrderInDB(
          _userId, shopName, threadTs, orderTs);
    }
    return response;
  }

  @override
  Future<void> addFavoriteDrink(String shopName, int drinkId,
      {String userId}) async {
    userId ??= await _localRepo.loadUserId().then((uid) {
      _userId = uid;
      return uid;
    });
    _localRepo.addFavoriteDrink(userId, shopName, drinkId);
  }

  @override
  Future<Drink> getFavoriteDrink(String shopName, {String userId}) async {
    userId ??= await _localRepo.loadUserId().then((uid) {
      _userId = uid;
      return uid;
    });
    int favoriteDrinkId = await _localRepo.getFavoriteDrinkId(userId, shopName);
    if (favoriteDrinkId == 0) {
      return null;
    }
    return _localRepo
        .getLocalDrinkData(drinkId: favoriteDrinkId)
        .then((drinkData) => Drink.fromMap(drinkData));
  }

  @override
  Future<List<Message>> fetchLatestJibbleMessage() async {
    String jibbleChannelId = await _localRepo.loadJibbleChannelId();
    Future<String> jibbleChannelIdFuture;
    if (Utils.isStringEmpty(jibbleChannelId)) {
      jibbleChannelIdFuture = _remoteRepo
          .fetchConversationList(_conversationType_im)
          .then((conversations) async {
        List<Channel> channels =
            conversations?.channels?.toList(growable: false);
        String channelId = channels
            ?.firstWhere((channel) => channel.user == jibbleUserId,
                orElse: () => null)
            ?.id;
        if (channelId != null) {
          await _localRepo.saveJibbleChannelId(channelId);
        }
        return channelId;
      });
    } else {
      jibbleChannelIdFuture = Future.value(jibbleChannelId);
    }
    return jibbleChannelIdFuture
        .then((jibbleChannelId) =>
            _remoteRepo.fetchConversationHistory(jibbleChannelId, limit: 10))
        .then((conversationHistory) => conversationHistory?.messages?.toList());
  }

  @override
  Future<bool> checkInOrOut(bool checkIn) {
    String message = checkIn ? "in" : "out";
    return _remoteRepo
        .postMessage(jibbleUserId, message)
        .then((response) => response.ok);
  }

  @override
  Future<bool> getCheckInReminderStatus() {
    return _localRepo.loadCheckInReminderStatus();
  }

  @override
  Future<void> changeCheckInReminderStatus(bool isEnabled) {
    return _localRepo.saveCheckInReminderStatus(isEnabled);
  }

  @override
  Future<void> clearLocalCache() {
    return _localRepo.saveJibbleChannelId(null);
  }
}
