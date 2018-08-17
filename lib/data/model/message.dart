import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';

part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {
  Message._();

  factory Message([updates(MessageBuilder b)]) = _$Message;

  @BuiltValueField(wireName: 'messages')
  BuiltList<Messages> get messages;

  @BuiltValueField(wireName: 'has_more')
  bool get hasMore;

  @BuiltValueField(wireName: 'ok')
  bool get ok;

  String toJson() {
    return json.encode(serializers.serializeWith(Message.serializer, this));
  }

  static Message fromJson(String jsonString) {
    return serializers.deserializeWith(
        Message.serializer, json.decode(jsonString));
  }

  static Serializer<Message> get serializer => _$messageSerializer;
}

abstract class Messages implements Built<Messages, MessagesBuilder> {
  Messages._();

  factory Messages([updates(MessagesBuilder b)]) = _$Messages;

  @BuiltValueField(wireName: 'type')
  String get type;

  @BuiltValueField(wireName: 'user')
  String get user;

  @BuiltValueField(wireName: 'text')
  String get text;

  @BuiltValueField(wireName: 'client_msg_id')
  String get clientMsgId;

  @BuiltValueField(wireName: 'thread_ts')
  String get threadTs;

  @BuiltValueField(wireName: 'reply_count')
  int get replyCount;

  @BuiltValueField(wireName: 'replies')
  BuiltList<Reply> get replies;

  @BuiltValueField(wireName: 'subscribed')
  bool get subscribed;

  @BuiltValueField(wireName: 'last_read')
  String get lastRead;

  @BuiltValueField(wireName: 'unread_count')
  int get unreadCount;

  @BuiltValueField(wireName: 'ts')
  String get ts;

  String toJson() {
    return json.encode(serializers.serializeWith(Messages.serializer, this));
  }

  static Messages fromJson(String jsonString) {
    return serializers.deserializeWith(
        Messages.serializer, json.decode(jsonString));
  }

  static Serializer<Messages> get serializer => _$messagesSerializer;
}

abstract class Reply implements Built<Reply, ReplyBuilder> {
  Reply._();

  factory Reply([updates(ReplyBuilder b)]) = _$Reply;

  @BuiltValueField(wireName: 'user')
  String get user;

  @BuiltValueField(wireName: 'ts')
  String get ts;

  String toJson() {
    return json.encode(serializers.serializeWith(Reply.serializer, this));
  }

  static Reply fromJson(String jsonString) {
    return serializers.deserializeWith(
        Reply.serializer, json.decode(jsonString));
  }

  static Serializer<Reply> get serializer => _$replySerializer;
}

