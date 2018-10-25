import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
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

class AppRepository implements Repository {
  static const String CLIENT_ID = AppRemoteRepo.SLACK_CLIENT_ID;
  static const String REDIRECT_URL = AppRemoteRepo.SLACK_REDIRECT_URL;

  static final AppRepository _repo = AppRepository._internal();

  static AppRepository get repo => _repo;

  RemoteRepo _remoteRepo;
  LocalRepo _localRepo;

  List<Members> _members;
  User currentUser;

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
    currentUser = (await _remoteRepo.getUserIdentity(accessToken: token))?.user;
    if (currentUser != null) {
      await _localRepo.saveUserData(currentUser.id, currentUser.name, token);
    }
    return token;
  }

  @override
  Future<List<Message>> fetchLatestDrinkMessages() async {
    const String ORDER_BROADCAST_KEYWORD = "今天點的是";

    if (_members == null || _members.isEmpty) {
      _members = await _remoteRepo
          .getTeamMemberProfile()
          .then((response) => response?.members?.where((member) {
                if (member.isBot || member.deleted) {
                  return false;
                }
                return true;
              })?.toList());
    }

    return Observable.fromFuture(_remoteRepo
            .fetchLunchMessages()
            .then((conversationList) {
              BuiltList<Message> messages = conversationList.messages;
              Message orderBroadcastMessage = messages.firstWhere(
                  (message) => message.text.contains(ORDER_BROADCAST_KEYWORD));
              String shopName = orderBroadcastMessage == null
                  ? ""
                  : (orderBroadcastMessage.text.split("："))[1];

              Message drinkMessage = messages.firstWhere((message) {
                if (message.files == null) {
                  return false;
                }
                return message.files[0].title.contains(shopName);
              });
              return drinkMessage == null ? "" : drinkMessage.ts;
            })
            .then((drinkMessageTs) =>
                _remoteRepo.fetchMessageReplies(drinkMessageTs))
            .then((drinkThread) => drinkThread.messages.toList()))
        .zipWith(Observable.just(_members), (messages, List<Members> members) {
      List<Message> zippedMessages = List();
      for (Message message in messages) {
        int index = members.indexWhere((member) => member.id == message.user);
        Message zippedMessage = Message((b) {
          b.replace(message);
          b.userProfile = index == -1 ? null : ProfileBuilder()
            ..replace(members[index].profile);
        });
        zippedMessages.add(zippedMessage);
      }
      return zippedMessages;
    }).first;
  }

  @override
  Future<PostMessageResponse> orderDrink(String threadTs, String drink) {
    return _remoteRepo.postMessage(threadTs, drink);
  }
}
