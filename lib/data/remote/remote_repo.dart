import 'dart:async';

import 'package:sprouter/data/model/conversation_history.dart';
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

  Future<ConversationList> fetchConversationList(String conversationType,
      {bool excludeArchived, int limit});

  Future<ConversationHistory> fetchConversationHistory(String channel,
      {String oldest, String latest, int limit});

  Future<ConversationHistory> fetchMessageReplies(String channel, String ts);

  Future<PostMessageResponse> postMessage(String channel, String text,
      {String ts});

  Future<UserListResponse> getTeamMemberProfile();

  Future<PostMessageResponse> updateMessage(
      String channel, String ts, String text);

  Future<PostMessageResponse> deleteMessage(String channel, String ts);
}
