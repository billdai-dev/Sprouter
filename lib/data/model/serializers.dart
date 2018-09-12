import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/slack/slack_token.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';
import 'package:sprouter/data/model/slack/user_list.dart';

part 'serializers.g.dart';

@SerializersFor(const [ConversationList, UserList, UserIdentity, SlackToken])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
