import 'dart:async';

import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/model/slack/slack_token.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';
import 'package:sprouter/data/model/slack/user_list.dart';

abstract class RemoteRepo {
  void setSlackTokenCache(String token);

  Future<SlackToken> getSlackOauthToken(String code);

  Future<UserIdentity> getUserIdentity({String accessToken});

  Future<UserListResponse> getUsers({String accessToken});

  Future<ConversationList> fetchLunchMessages(
      {String oldest, String latest, int limit});

  Future<ConversationList> fetchMessageReplies(String ts);

  Future<PostMessageResponse> postMessage(String ts, String text);

  Future<UserListResponse> getTeamMemberProfile();

  Future<PostMessageResponse> updateMessage(String ts, String text);
}
