import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';
import 'package:sprouter/data/model/slack/profile.dart';

part 'user_identity.g.dart';

abstract class UserIdentity
    implements Built<UserIdentity, UserIdentityBuilder> {
  UserIdentity._();

  factory UserIdentity([updates(UserIdentityBuilder b)]) = _$UserIdentity;

  @BuiltValueField(wireName: 'ok')
  bool get ok;

  @nullable
  @BuiltValueField(wireName: 'user')
  User get user;

  @nullable
  @BuiltValueField(wireName: 'team')
  Team get team;

  String toJson() {
    return json
        .encode(serializers.serializeWith(UserIdentity.serializer, this));
  }

  static UserIdentity fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserIdentity.serializer, json.decode(jsonString));
  }

  static Serializer<UserIdentity> get serializer => _$userIdentitySerializer;
}

abstract class User implements Built<User, UserBuilder> {
  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'id')
  String get id;

  @nullable
  @BuiltValueField(wireName: 'image_24')
  String get image24;

  @nullable
  @BuiltValueField(wireName: 'image_32')
  String get image32;

  @nullable
  @BuiltValueField(wireName: 'image_48')
  String get image48;

  @nullable
  @BuiltValueField(wireName: 'image_72')
  String get image72;

  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User fromJson(String jsonString) {
    return serializers.deserializeWith(
        User.serializer, json.decode(jsonString));
  }

  static Serializer<User> get serializer => _$userSerializer;
}

abstract class Team implements Built<Team, TeamBuilder> {
  Team._();

  factory Team([updates(TeamBuilder b)]) = _$Team;

  @nullable
  @BuiltValueField(wireName: 'id')
  String get id;

  String toJson() {
    return json.encode(serializers.serializeWith(Team.serializer, this));
  }

  static Team fromJson(String jsonString) {
    return serializers.deserializeWith(
        Team.serializer, json.decode(jsonString));
  }

  static Serializer<Team> get serializer => _$teamSerializer;
}
