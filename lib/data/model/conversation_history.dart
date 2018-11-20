import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/serializers.dart';

part 'conversation_history.g.dart';

abstract class ConversationHistory
    implements Built<ConversationHistory, ConversationHistoryBuilder> {
  ConversationHistory._();

  factory ConversationHistory([updates(ConversationHistoryBuilder b)]) =
      _$ConversationHistory;

  @nullable
  @BuiltValueField(wireName: 'messages')
  BuiltList<Message> get messages;

  @nullable
  @BuiltValueField(wireName: 'has_more')
  bool get hasMore;

  @nullable
  @BuiltValueField(wireName: 'ok')
  bool get ok;

  @nullable
  @BuiltValueField(wireName: 'error')
  String get error;

  String toJson() {
    return json.encode(
        serializers.serializeWith(ConversationHistory.serializer, this));
  }

  static ConversationHistory fromJson(String jsonString) {
    return serializers.deserializeWith(
        ConversationHistory.serializer, json.decode(jsonString));
  }

  static Serializer<ConversationHistory> get serializer =>
      _$conversationHistorySerializer;
}
