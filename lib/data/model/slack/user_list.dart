import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';
import 'package:sprouter/data/model/slack/profile.dart';

part 'user_list.g.dart';

abstract class UserList implements Built<UserList, UserListBuilder> {
  UserList._();

  factory UserList([updates(UserListBuilder b)]) = _$UserList;

  @BuiltValueField(wireName: 'ok')
  bool get ok;

  @nullable
  @BuiltValueField(wireName: 'members')
  BuiltList<Members> get members;

  String toJson() {
    return json.encode(serializers.serializeWith(UserList.serializer, this));
  }

  static UserList fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserList.serializer, json.decode(jsonString));
  }

  static Serializer<UserList> get serializer => _$userListSerializer;
}

abstract class Members implements Built<Members, MembersBuilder> {
  Members._();

  factory Members([updates(MembersBuilder b)]) = _$Members;

  @BuiltValueField(wireName: 'id')
  String get id;

  @nullable
  @BuiltValueField(wireName: 'team_id')
  String get teamId;

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'deleted')
  bool get deleted;

  @nullable
  @BuiltValueField(wireName: 'profile')
  Profile get profile;

  @nullable
  @BuiltValueField(wireName: 'is_bot')
  bool get isBot;

  String toJson() {
    return json.encode(serializers.serializeWith(Members.serializer, this));
  }

  static Members fromJson(String jsonString) {
    return serializers.deserializeWith(
        Members.serializer, json.decode(jsonString));
  }

  static Serializer<Members> get serializer => _$membersSerializer;
}
