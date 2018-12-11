import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';
import 'package:sprouter/data/model/slack/profile.dart';

part 'simple_identity_response.g.dart';

abstract class SimpleIdentityResponse
    implements Built<SimpleIdentityResponse, SimpleIdentityResponseBuilder> {
  SimpleIdentityResponse._();

  factory SimpleIdentityResponse([updates(SimpleIdentityResponseBuilder b)]) =
      _$SimpleIdentityResponse;

  @BuiltValueField(wireName: 'ok')
  bool get ok;

  @nullable
  @BuiltValueField(wireName: 'user')
  String get user;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  String get userId;

  String toJson() {
    return json.encode(
        serializers.serializeWith(SimpleIdentityResponse.serializer, this));
  }

  static SimpleIdentityResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        SimpleIdentityResponse.serializer, json.decode(jsonString));
  }

  static Serializer<SimpleIdentityResponse> get serializer =>
      _$simpleIdentityResponseSerializer;
}
