import 'dart:async';

import 'package:built_collection/built_collection.dart';
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
    const String ORDER_BROADCAST_KEYWORD = "今天點的是";

    Future<List<Members>> getMembersFuture =
        _members == null || _members.isEmpty
            ? _remoteRepo.getTeamMemberProfile().then((response) => response
                ?.members
                ?.where((member) => !member.isBot && !member.deleted)
                ?.toList())
            : Future.value(_members);

    Future<List<Message>> getOrderRepliesFuture = _remoteRepo
        .fetchLunchMessages() //1. 抓出 Lunch channel 前 N 筆 message
        .then((conversationList) async {
          BuiltList<Message> messages = conversationList.messages;
          //2. 用關鍵字 parse 出"最新"廣播訊息的 message
          Message orderBroadcastMessage = messages.firstWhere(
              (message) => message.text.contains(ORDER_BROADCAST_KEYWORD));
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
          return drinkMessage == null ? "" : drinkMessage.ts;
        })
        //5. 用 點單 thread 的 ts 抓出其底下所有 reply
        .then(
            (drinkMessageTs) => _remoteRepo.fetchMessageReplies(drinkMessageTs))
        .then((drinkThread) => drinkThread.messages.toList());

    //6. 結合會員列表和 reply 資料, 最後回傳加上會員資料的 reply[]
    return Future.wait([getMembersFuture, getOrderRepliesFuture])
        .then((results) {
      if (results[0] is List<Members>) {
        _members ??= results[0];
      }
      if (!(results[1] is List<Message>)) {
        return [];
      }
      List<Message> drinkMessages = results[1];
      List<Message> zippedMessages = List();
      for (Message message in drinkMessages) {
        int index = _members?.indexWhere((member) => member.id == message.user);
        Message zippedMessage = Message((b) {
          b.replace(message);
          b.userProfile = index == -1 ? null : ProfileBuilder()
            ..replace(_members[index].profile);
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
      await _localRepo.addDrinkOrderToDB(_userId, shopName, threadTs, drinkId);
    }
    return response;
  }
}
