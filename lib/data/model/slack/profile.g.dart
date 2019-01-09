// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Profile> _$profileSerializer = new _$ProfileSerializer();

class _$ProfileSerializer implements StructuredSerializer<Profile> {
  @override
  final Iterable<Type> types = const [Profile, _$Profile];
  @override
  final String wireName = 'Profile';

  @override
  Iterable serialize(Serializers serializers, Profile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.realName != null) {
      result
        ..add('real_name')
        ..add(serializers.serialize(object.realName,
            specifiedType: const FullType(String)));
    }
    if (object.realNameNormalized != null) {
      result
        ..add('real_name_normalized')
        ..add(serializers.serialize(object.realNameNormalized,
            specifiedType: const FullType(String)));
    }
    if (object.displayName != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(object.displayName,
            specifiedType: const FullType(String)));
    }
    if (object.displayNameNormalized != null) {
      result
        ..add('display_name_normalized')
        ..add(serializers.serialize(object.displayNameNormalized,
            specifiedType: const FullType(String)));
    }
    if (object.avatarHash != null) {
      result
        ..add('avatar_hash')
        ..add(serializers.serialize(object.avatarHash,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.imageOriginal != null) {
      result
        ..add('image_original')
        ..add(serializers.serialize(object.imageOriginal,
            specifiedType: const FullType(String)));
    }
    if (object.image24 != null) {
      result
        ..add('image_24')
        ..add(serializers.serialize(object.image24,
            specifiedType: const FullType(String)));
    }
    if (object.image32 != null) {
      result
        ..add('image_32')
        ..add(serializers.serialize(object.image32,
            specifiedType: const FullType(String)));
    }
    if (object.image48 != null) {
      result
        ..add('image_48')
        ..add(serializers.serialize(object.image48,
            specifiedType: const FullType(String)));
    }
    if (object.image72 != null) {
      result
        ..add('image_72')
        ..add(serializers.serialize(object.image72,
            specifiedType: const FullType(String)));
    }
    if (object.image192 != null) {
      result
        ..add('image_192')
        ..add(serializers.serialize(object.image192,
            specifiedType: const FullType(String)));
    }
    if (object.image512 != null) {
      result
        ..add('image_512')
        ..add(serializers.serialize(object.image512,
            specifiedType: const FullType(String)));
    }
    if (object.statusTextCanonical != null) {
      result
        ..add('status_text_canonical')
        ..add(serializers.serialize(object.statusTextCanonical,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Profile deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'real_name':
          result.realName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'real_name_normalized':
          result.realNameNormalized = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name_normalized':
          result.displayNameNormalized = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar_hash':
          result.avatarHash = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_original':
          result.imageOriginal = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_24':
          result.image24 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_32':
          result.image32 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_48':
          result.image48 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_72':
          result.image72 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_192':
          result.image192 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_512':
          result.image512 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_text_canonical':
          result.statusTextCanonical = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Profile extends Profile {
  @override
  final String title;
  @override
  final String realName;
  @override
  final String realNameNormalized;
  @override
  final String displayName;
  @override
  final String displayNameNormalized;
  @override
  final String avatarHash;
  @override
  final String email;
  @override
  final String imageOriginal;
  @override
  final String image24;
  @override
  final String image32;
  @override
  final String image48;
  @override
  final String image72;
  @override
  final String image192;
  @override
  final String image512;
  @override
  final String statusTextCanonical;

  factory _$Profile([void updates(ProfileBuilder b)]) =>
      (new ProfileBuilder()..update(updates)).build();

  _$Profile._(
      {this.title,
      this.realName,
      this.realNameNormalized,
      this.displayName,
      this.displayNameNormalized,
      this.avatarHash,
      this.email,
      this.imageOriginal,
      this.image24,
      this.image32,
      this.image48,
      this.image72,
      this.image192,
      this.image512,
      this.statusTextCanonical})
      : super._();

  @override
  Profile rebuild(void updates(ProfileBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileBuilder toBuilder() => new ProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
        title == other.title &&
        realName == other.realName &&
        realNameNormalized == other.realNameNormalized &&
        displayName == other.displayName &&
        displayNameNormalized == other.displayNameNormalized &&
        avatarHash == other.avatarHash &&
        email == other.email &&
        imageOriginal == other.imageOriginal &&
        image24 == other.image24 &&
        image32 == other.image32 &&
        image48 == other.image48 &&
        image72 == other.image72 &&
        image192 == other.image192 &&
        image512 == other.image512 &&
        statusTextCanonical == other.statusTextCanonical;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(0,
                                                                title.hashCode),
                                                            realName.hashCode),
                                                        realNameNormalized
                                                            .hashCode),
                                                    displayName.hashCode),
                                                displayNameNormalized.hashCode),
                                            avatarHash.hashCode),
                                        email.hashCode),
                                    imageOriginal.hashCode),
                                image24.hashCode),
                            image32.hashCode),
                        image48.hashCode),
                    image72.hashCode),
                image192.hashCode),
            image512.hashCode),
        statusTextCanonical.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Profile')
          ..add('title', title)
          ..add('realName', realName)
          ..add('realNameNormalized', realNameNormalized)
          ..add('displayName', displayName)
          ..add('displayNameNormalized', displayNameNormalized)
          ..add('avatarHash', avatarHash)
          ..add('email', email)
          ..add('imageOriginal', imageOriginal)
          ..add('image24', image24)
          ..add('image32', image32)
          ..add('image48', image48)
          ..add('image72', image72)
          ..add('image192', image192)
          ..add('image512', image512)
          ..add('statusTextCanonical', statusTextCanonical))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _realName;
  String get realName => _$this._realName;
  set realName(String realName) => _$this._realName = realName;

  String _realNameNormalized;
  String get realNameNormalized => _$this._realNameNormalized;
  set realNameNormalized(String realNameNormalized) =>
      _$this._realNameNormalized = realNameNormalized;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _displayNameNormalized;
  String get displayNameNormalized => _$this._displayNameNormalized;
  set displayNameNormalized(String displayNameNormalized) =>
      _$this._displayNameNormalized = displayNameNormalized;

  String _avatarHash;
  String get avatarHash => _$this._avatarHash;
  set avatarHash(String avatarHash) => _$this._avatarHash = avatarHash;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _imageOriginal;
  String get imageOriginal => _$this._imageOriginal;
  set imageOriginal(String imageOriginal) =>
      _$this._imageOriginal = imageOriginal;

  String _image24;
  String get image24 => _$this._image24;
  set image24(String image24) => _$this._image24 = image24;

  String _image32;
  String get image32 => _$this._image32;
  set image32(String image32) => _$this._image32 = image32;

  String _image48;
  String get image48 => _$this._image48;
  set image48(String image48) => _$this._image48 = image48;

  String _image72;
  String get image72 => _$this._image72;
  set image72(String image72) => _$this._image72 = image72;

  String _image192;
  String get image192 => _$this._image192;
  set image192(String image192) => _$this._image192 = image192;

  String _image512;
  String get image512 => _$this._image512;
  set image512(String image512) => _$this._image512 = image512;

  String _statusTextCanonical;
  String get statusTextCanonical => _$this._statusTextCanonical;
  set statusTextCanonical(String statusTextCanonical) =>
      _$this._statusTextCanonical = statusTextCanonical;

  ProfileBuilder();

  ProfileBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _realName = _$v.realName;
      _realNameNormalized = _$v.realNameNormalized;
      _displayName = _$v.displayName;
      _displayNameNormalized = _$v.displayNameNormalized;
      _avatarHash = _$v.avatarHash;
      _email = _$v.email;
      _imageOriginal = _$v.imageOriginal;
      _image24 = _$v.image24;
      _image32 = _$v.image32;
      _image48 = _$v.image48;
      _image72 = _$v.image72;
      _image192 = _$v.image192;
      _image512 = _$v.image512;
      _statusTextCanonical = _$v.statusTextCanonical;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Profile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Profile;
  }

  @override
  void update(void updates(ProfileBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Profile build() {
    final _$result = _$v ??
        new _$Profile._(
            title: title,
            realName: realName,
            realNameNormalized: realNameNormalized,
            displayName: displayName,
            displayNameNormalized: displayNameNormalized,
            avatarHash: avatarHash,
            email: email,
            imageOriginal: imageOriginal,
            image24: image24,
            image32: image32,
            image48: image48,
            image72: image72,
            image192: image192,
            image512: image512,
            statusTextCanonical: statusTextCanonical);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
