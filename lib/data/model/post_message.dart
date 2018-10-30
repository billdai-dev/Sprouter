import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/serializers.dart';

part 'post_message.g.dart';

abstract class PostMessageRequest
    implements Built<PostMessageRequest, PostMessageRequestBuilder> {
  PostMessageRequest._();

  factory PostMessageRequest([updates(PostMessageRequestBuilder b)]) =
      _$PostMessageRequest;

  @BuiltValueField(wireName: 'channel')
  String get channel;

  @BuiltValueField(wireName: 'text')
  String get text;

  @BuiltValueField(wireName: 'as_user')
  bool get asUser;

  @nullable
  @BuiltValueField(wireName: 'thread_ts')
  String get threadTs;

  @nullable
  @BuiltValueField(wireName: 'ts')
  String get ts;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PostMessageRequest.serializer, this));
  }

  static PostMessageRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        PostMessageRequest.serializer, json.decode(jsonString));
  }

  static Serializer<PostMessageRequest> get serializer =>
      _$postMessageRequestSerializer;
}

abstract class PostMessageResponse
    implements Built<PostMessageResponse, PostMessageResponseBuilder> {
  PostMessageResponse._();

  factory PostMessageResponse([updates(PostMessageResponseBuilder b)]) =
      _$PostMessageResponse;

  @BuiltValueField(wireName: 'ok')
  bool get ok;

  @nullable
  @BuiltValueField(wireName: 'channel')
  String get channel;

  @nullable
  @BuiltValueField(wireName: 'ts')
  String get ts;

  @BuiltValueField(wireName: 'message')
  Message get message;

  String toJson() {
    return json.encode(
        serializers.serializeWith(PostMessageResponse.serializer, this));
  }

  static PostMessageResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        PostMessageResponse.serializer, json.decode(jsonString));
  }

  static Serializer<PostMessageResponse> get serializer =>
      _$postMessageResponseSerializer;
}
