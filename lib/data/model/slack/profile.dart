import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';

part 'profile.g.dart';

abstract class Profile implements Built<Profile, ProfileBuilder> {
  Profile._();

  factory Profile([updates(ProfileBuilder b)]) = _$Profile;

  @nullable
  @BuiltValueField(wireName: 'title')
  String get title;

  @nullable
  @BuiltValueField(wireName: 'real_name')
  String get realName;

  @nullable
  @BuiltValueField(wireName: 'real_name_normalized')
  String get realNameNormalized;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'display_name_normalized')
  String get displayNameNormalized;

  @nullable
  @BuiltValueField(wireName: 'avatar_hash')
  String get avatarHash;

  @nullable
  @BuiltValueField(wireName: 'email')
  String get email;

  @nullable
  @BuiltValueField(wireName: 'image_original')
  String get imageOriginal;

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
  @nullable
  @BuiltValueField(wireName: 'status_text_canonical')
  String get statusTextCanonical;

  String toJson() {
    return json.encode(serializers.serializeWith(Profile.serializer, this));
  }

  static Profile fromJson(String jsonString) {
    return serializers.deserializeWith(
        Profile.serializer, json.decode(jsonString));
  }

  static Serializer<Profile> get serializer => _$profileSerializer;
}
