import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:sprouter/data/model/slack/profile.dart';
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/model/slack/slack_token.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';
import 'package:sprouter/data/model/slack/user_list.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  ConversationList,
  UserListResponse,
  Profile,
  UserIdentity,
  SlackToken,
  PostMessageRequest,
  PostMessageResponse,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
