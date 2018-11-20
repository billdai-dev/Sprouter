import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'conversation_list.g.dart';

abstract class ConversationList
    implements Built<ConversationList, ConversationListBuilder> {
  ConversationList._();

  factory ConversationList([updates(ConversationListBuilder b)]) =
      _$ConversationList;

  @nullable
  @BuiltValueField(wireName: 'ok')
  bool get ok;

  @nullable
  @BuiltValueField(wireName: 'channels')
  BuiltList<Channels> get channels;

  @nullable
  @BuiltValueField(wireName: 'response_metadata')
  ResponseMetadata get responseMetadata;

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

abstract class Channels implements Built<Channels, ChannelsBuilder> {
  Channels._();

  factory Channels([updates(ChannelsBuilder b)]) = _$Channels;

  @nullable
  @BuiltValueField(wireName: 'id')
  String get id;

  @nullable
  @BuiltValueField(wireName: 'created')
  int get created;

  @nullable
  @BuiltValueField(wireName: 'is_im')
  bool get isIm;

  @nullable
  @BuiltValueField(wireName: 'is_org_shared')
  bool get isOrgShared;

  @nullable
  @BuiltValueField(wireName: 'user')
  String get user;

  @nullable
  @BuiltValueField(wireName: 'is_user_deleted')
  bool get isUserDeleted;

  @nullable
  @BuiltValueField(wireName: 'priority')
  int get priority;

  String toJson() {
    return json.encode(serializers.serializeWith(Channels.serializer, this));
  }

  static Channels fromJson(String jsonString) {
    return serializers.deserializeWith(
        Channels.serializer, json.decode(jsonString));
  }

  static Serializer<Channels> get serializer => _$channelsSerializer;
}

abstract class ResponseMetadata
    implements Built<ResponseMetadata, ResponseMetadataBuilder> {
  ResponseMetadata._();

  factory ResponseMetadata([updates(ResponseMetadataBuilder b)]) =
      _$ResponseMetadata;

  @nullable
  @BuiltValueField(wireName: 'next_cursor')
  String get nextCursor;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ResponseMetadata.serializer, this));
  }

  static ResponseMetadata fromJson(String jsonString) {
    return serializers.deserializeWith(
        ResponseMetadata.serializer, json.decode(jsonString));
  }

  static Serializer<ResponseMetadata> get serializer =>
      _$responseMetadataSerializer;
}
