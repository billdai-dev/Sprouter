import 'dart:async';

import 'package:sprouter/data/local/app_local_repo.dart';
import 'package:sprouter/data/local/local_repo.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/model/slack/profile.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';
import 'package:sprouter/data/model/slack/user_list.dart';
import 'package:sprouter/data/remote/app_remote_repo.dart';
import 'package:sprouter/data/remote/remote_repo.dart';
import 'package:sprouter/data/repository.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';

class AppRepository implements Repository {
  static const String CLIENT_ID = AppRemoteRepo.SLACK_CLIENT_ID;
  static const String REDIRECT_URL = AppRemoteRepo.SLACK_REDIRECT_URL;

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

    Future<List<Members>> getMembersFuture =
        _members == null || _members.isEmpty
            ? _remoteRepo.getTeamMemberProfile().then((response) => response
                ?.members
                ?.where((member) => !member.isBot && !member.deleted)
                ?.toList())
            : Future.value(_members);

    Message thread = await _remoteRepo
        .fetchLunchMessages() //1. 抓出 Lunch channel 前 N 筆 message
        .then((conversationList) async {
      List<Message> messages = conversationList.messages.toList();
      //2. 用關鍵字 parse 出"最新"廣播訊息的 message
      Message orderBroadcastMessage = messages.firstWhere(
          (message) => message.text.contains(orderBroadcastKeyword));
      //3. 找出店家名稱
      String shopName = orderBroadcastMessage == null
          ? ""
          : (orderBroadcastMessage.text.split("："))[1];
      //4. 用店家名稱 parse 出"最新"點單 thread 的 message
      Message drinkMessage = messages.firstWhere((message) {
        if (message.files == null) {
          return false; //點單 thread 必定有 file (菜單圖片)，先過濾一層
        }
        return message.files[0].title.contains(shopName);
      });
      await _localRepo.addShopToDB(shopName, drinkMessage.ts); //保存店家資料到DB
      return drinkMessage;
    });
    String shopName = thread.files[0]?.title?.split(" ")[1];
    String ts = thread.threadTs;

    //5. 用 點單 thread 的 ts 抓出其底下所有 reply
    Future<List<Message>> getOrderRepliesFuture = _remoteRepo
        .fetchMessageReplies(ts)
        .then((drinkThread) => drinkThread.messages.toList());

    //6. 抓 Database 中有儲存的 order
    Future<List<String>> getOrderTsListFuture =
        _localRepo.getOrderTsList(shopName, ts);

    //7. 結合會員列表、reply 資料和 database 資料, 最後回傳加料過的 reply[]
    return Future.wait(
            [getMembersFuture, getOrderTsListFuture, getOrderRepliesFuture])
        .then((results) {
      if (results[0] is List<Members>) {
        _members ??= results[0];
      }
      List<String> orderTsList;
      if (results[1] is List<String>) {
        orderTsList = results[1];
      }
      orderTsList ??= List<String>();
      if (!(results[2] is List<Message>)) {
        return [];
      }
      List<Message> drinkMessages = results[2];
      List<Message> zippedMessages = List();
      for (Message message in drinkMessages) {
        int memberIndex =
            _members?.indexWhere((member) => member.id == message.user);
        int orderTsIndex =
            orderTsList?.indexWhere((orderTs) => orderTs == message.ts);
        Message zippedMessage = Message((b) {
          b.replace(message);
          b.userProfile = memberIndex == -1 ? null : ProfileBuilder()
            ..replace(_members[memberIndex]?.profile);
          b.isAddedBySprouter = orderTsIndex != -1;
        });
        zippedMessages.add(zippedMessage);
      }
      return zippedMessages;
    });
  }

  @override
  Future<PostMessageResponse> orderDrink(
      String shopName, String threadTs, Drink drink,
      {String orderTs}) async {
    String completeDrinkName = drink?.completeDrinkName;
    PostMessageResponse response =
        await _remoteRepo.postMessage(threadTs, completeDrinkName);
    if (response != null && response.ok) {
      int drinkId = await _localRepo.addDrinkToDB(drink,
          threadTs: threadTs, orderTs: orderTs);
      _userId ??= await _localRepo.loadUserId();
      await _localRepo.addDrinkOrderToDB(
          _userId, shopName, threadTs, drinkId, orderTs ?? response.ts);
    }
    return response;
  }
}
