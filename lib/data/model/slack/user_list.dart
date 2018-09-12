import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';

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

abstract class Profile implements Built<Profile, ProfileBuilder> {
  Profile._();

  factory Profile([updates(ProfileBuilder b)]) = _$Profile;

  @nullable
  @BuiltValueField(wireName: 'avatar_hash')
  String get avatarHash;

  @nullable
  @BuiltValueField(wireName: 'status_text')
  String get statusText;

  @nullable
  @BuiltValueField(wireName: 'status_emoji')
  String get statusEmoji;

  @nullable
  @BuiltValueField(wireName: 'real_name')
  String get realName;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'real_name_normalized')
  String get realNameNormalized;

  @nullable
  @BuiltValueField(wireName: 'display_name_normalized')
  String get displayNameNormalized;

  @nullable
  @BuiltValueField(wireName: 'email')
  String get email;

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

  @nullable
  @BuiltValueField(wireName: 'image_192')
  String get image192;

  @nullable
  @BuiltValueField(wireName: 'image_512')
  String get image512;

  @nullable
  @BuiltValueField(wireName: 'team')
  String get team;

  String toJson() {
    return json.encode(serializers.serializeWith(Profile.serializer, this));
  }

  static Profile fromJson(String jsonString) {
    return serializers.deserializeWith(
        Profile.serializer, json.decode(jsonString));
  }

  static Serializer<Profile> get serializer => _$profileSerializer;
}
