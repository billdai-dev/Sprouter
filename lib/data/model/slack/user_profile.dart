import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';
import 'package:sprouter/data/model/slack/profile.dart';

part 'user_profile.g.dart';

abstract class UserProfileResponse
    implements Built<UserProfileResponse, UserProfileBuilder> {
  UserProfileResponse._();

  factory UserProfileResponse([updates(UserProfileBuilder b)]) = _$UserProfile;

  @nullable
  @BuiltValueField(wireName: 'ok')
  bool get ok;

  @nullable
  @BuiltValueField(wireName: 'profile')
  Profile get profile;

  String toJson() {
    return json.encode(
        serializers.serializeWith(UserProfileResponse.serializer, this));
  }

  static UserProfileResponse fromJson(String jsonString) {
    try {
      return serializers.deserializeWith(
          UserProfileResponse.serializer, json.decode(jsonString));
    } catch (e) {
      print(e);
    }
  }

  static Serializer<UserProfileResponse> get serializer =>
      _$userProfileSerializer;
}
