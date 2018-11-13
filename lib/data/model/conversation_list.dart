import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/serializers.dart';

part 'conversation_list.g.dart';

abstract class ConversationList
    implements Built<ConversationList, ConversationListBuilder> {
  ConversationList._();

  factory ConversationList([updates(ConversationListBuilder b)]) =
      _$ConversationList;

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
    return json
        .encode(serializers.serializeWith(ConversationList.serializer, this));
  }

  static ConversationList fromJson(String jsonString) {
    return serializers.deserializeWith(
        ConversationList.serializer, json.decode(jsonString));
  }

  static Serializer<ConversationList> get serializer =>
      _$conversationListSerializer;
}
