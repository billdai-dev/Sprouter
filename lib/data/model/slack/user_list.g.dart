// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<UserList> _$userListSerializer = new _$UserListSerializer();
Serializer<Members> _$membersSerializer = new _$MembersSerializer();
Serializer<Profile> _$profileSerializer = new _$ProfileSerializer();

class _$UserListSerializer implements StructuredSerializer<UserList> {
  @override
  final Iterable<Type> types = const [UserList, _$UserList];
  @override
  final String wireName = 'UserList';

  @override
  Iterable serialize(Serializers serializers, UserList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ok',
      serializers.serialize(object.ok, specifiedType: const FullType(bool)),
    ];
    if (object.members != null) {
      result
        ..add('members')
        ..add(serializers.serialize(object.members,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Members)])));
    }

    return result;
  }

  @override
  UserList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'ok':
          result.ok = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'members':
          result.members.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Members)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$MembersSerializer implements StructuredSerializer<Members> {
  @override
  final Iterable<Type> types = const [Members, _$Members];
  @override
  final String wireName = 'Members';

  @override
  Iterable serialize(Serializers serializers, Members object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    if (object.teamId != null) {
      result
        ..add('team_id')
        ..add(serializers.serialize(object.teamId,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.deleted != null) {
      result
        ..add('deleted')
        ..add(serializers.serialize(object.deleted,
            specifiedType: const FullType(bool)));
    }
    if (object.profile != null) {
      result
        ..add('profile')
        ..add(serializers.serialize(object.profile,
            specifiedType: const FullType(Profile)));
    }
    if (object.isBot != null) {
      result
        ..add('is_bot')
        ..add(serializers.serialize(object.isBot,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  Members deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MembersBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'team_id':
          result.teamId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'deleted':
          result.deleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'profile':
          result.profile.replace(serializers.deserialize(value,
              specifiedType: const FullType(Profile)) as Profile);
          break;
        case 'is_bot':
          result.isBot = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ProfileSerializer implements StructuredSerializer<Profile> {
  @override
  final Iterable<Type> types = const [Profile, _$Profile];
  @override
  final String wireName = 'Profile';

  @override
  Iterable serialize(Serializers serializers, Profile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.avatarHash != null) {
      result
        ..add('avatar_hash')
        ..add(serializers.serialize(object.avatarHash,
            specifiedType: const FullType(String)));
    }
    if (object.statusText != null) {
      result
        ..add('status_text')
        ..add(serializers.serialize(object.statusText,
            specifiedType: const FullType(String)));
    }
    if (object.statusEmoji != null) {
      result
        ..add('status_emoji')
        ..add(serializers.serialize(object.statusEmoji,
            specifiedType: const FullType(String)));
    }
    if (object.realName != null) {
      result
        ..add('real_name')
        ..add(serializers.serialize(object.realName,
            specifiedType: const FullType(String)));
    }
    if (object.displayName != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(object.displayName,
            specifiedType: const FullType(String)));
    }
    if (object.realNameNormalized != null) {
      result
        ..add('real_name_normalized')
        ..add(serializers.serialize(object.realNameNormalized,
            specifiedType: const FullType(String)));
    }
    if (object.displayNameNormalized != null) {
      result
        ..add('display_name_normalized')
        ..add(serializers.serialize(object.displayNameNormalized,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
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
    if (object.team != null) {
      result
        ..add('team')
        ..add(serializers.serialize(object.team,
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
        case 'avatar_hash':
          result.avatarHash = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_text':
          result.statusText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_emoji':
          result.statusEmoji = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'real_name':
          result.realName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'real_name_normalized':
          result.realNameNormalized = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name_normalized':
          result.displayNameNormalized = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
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
        case 'team':
          result.team = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserList extends UserList {
  @override
  final bool ok;
  @override
  final BuiltList<Members> members;

  factory _$UserList([void updates(UserListBuilder b)]) =>
      (new UserListBuilder()..update(updates)).build();

  _$UserList._({this.ok, this.members}) : super._() {
    if (ok == null) {
      throw new BuiltValueNullFieldError('UserList', 'ok');
    }
  }

  @override
  UserList rebuild(void updates(UserListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserListBuilder toBuilder() => new UserListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserList && ok == other.ok && members == other.members;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, ok.hashCode), members.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserList')
          ..add('ok', ok)
          ..add('members', members))
        .toString();
  }
}

class UserListBuilder implements Builder<UserList, UserListBuilder> {
  _$UserList _$v;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  ListBuilder<Members> _members;
  ListBuilder<Members> get members =>
      _$this._members ??= new ListBuilder<Members>();
  set members(ListBuilder<Members> members) => _$this._members = members;

  UserListBuilder();

  UserListBuilder get _$this {
    if (_$v != null) {
      _ok = _$v.ok;
      _members = _$v.members?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserList;
  }

  @override
  void update(void updates(UserListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserList build() {
    _$UserList _$result;
    try {
      _$result = _$v ?? new _$UserList._(ok: ok, members: _members?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'members';
        _members?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Members extends Members {
  @override
  final String id;
  @override
  final String teamId;
  @override
  final String name;
  @override
  final bool deleted;
  @override
  final Profile profile;
  @override
  final bool isBot;

  factory _$Members([void updates(MembersBuilder b)]) =>
      (new MembersBuilder()..update(updates)).build();

  _$Members._(
      {this.id, this.teamId, this.name, this.deleted, this.profile, this.isBot})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Members', 'id');
    }
  }

  @override
  Members rebuild(void updates(MembersBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MembersBuilder toBuilder() => new MembersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Members &&
        id == other.id &&
        teamId == other.teamId &&
        name == other.name &&
        deleted == other.deleted &&
        profile == other.profile &&
        isBot == other.isBot;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), teamId.hashCode), name.hashCode),
                deleted.hashCode),
            profile.hashCode),
        isBot.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Members')
          ..add('id', id)
          ..add('teamId', teamId)
          ..add('name', name)
          ..add('deleted', deleted)
          ..add('profile', profile)
          ..add('isBot', isBot))
        .toString();
  }
}

class MembersBuilder implements Builder<Members, MembersBuilder> {
  _$Members _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _teamId;
  String get teamId => _$this._teamId;
  set teamId(String teamId) => _$this._teamId = teamId;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _deleted;
  bool get deleted => _$this._deleted;
  set deleted(bool deleted) => _$this._deleted = deleted;

  ProfileBuilder _profile;
  ProfileBuilder get profile => _$this._profile ??= new ProfileBuilder();
  set profile(ProfileBuilder profile) => _$this._profile = profile;

  bool _isBot;
  bool get isBot => _$this._isBot;
  set isBot(bool isBot) => _$this._isBot = isBot;

  MembersBuilder();

  MembersBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _teamId = _$v.teamId;
      _name = _$v.name;
      _deleted = _$v.deleted;
      _profile = _$v.profile?.toBuilder();
      _isBot = _$v.isBot;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Members other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Members;
  }

  @override
  void update(void updates(MembersBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Members build() {
    _$Members _$result;
    try {
      _$result = _$v ??
          new _$Members._(
              id: id,
              teamId: teamId,
              name: name,
              deleted: deleted,
              profile: _profile?.build(),
              isBot: isBot);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'profile';
        _profile?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Members', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Profile extends Profile {
  @override
  final String avatarHash;
  @override
  final String statusText;
  @override
  final String statusEmoji;
  @override
  final String realName;
  @override
  final String displayName;
  @override
  final String realNameNormalized;
  @override
  final String displayNameNormalized;
  @override
  final String email;
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
  final String team;

  factory _$Profile([void updates(ProfileBuilder b)]) =>
      (new ProfileBuilder()..update(updates)).build();

  _$Profile._(
      {this.avatarHash,
      this.statusText,
      this.statusEmoji,
      this.realName,
      this.displayName,
      this.realNameNormalized,
      this.displayNameNormalized,
      this.email,
      this.image24,
      this.image32,
      this.image48,
      this.image72,
      this.image192,
      this.image512,
      this.team})
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
        avatarHash == other.avatarHash &&
        statusText == other.statusText &&
        statusEmoji == other.statusEmoji &&
        realName == other.realName &&
        displayName == other.displayName &&
        realNameNormalized == other.realNameNormalized &&
        displayNameNormalized == other.displayNameNormalized &&
        email == other.email &&
        image24 == other.image24 &&
        image32 == other.image32 &&
        image48 == other.image48 &&
        image72 == other.image72 &&
        image192 == other.image192 &&
        image512 == other.image512 &&
        team == other.team;
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
                                                            $jc(
                                                                0,
                                                                avatarHash
                                                                    .hashCode),
                                                            statusText
                                                                .hashCode),
                                                        statusEmoji.hashCode),
                                                    realName.hashCode),
                                                displayName.hashCode),
                                            realNameNormalized.hashCode),
                                        displayNameNormalized.hashCode),
                                    email.hashCode),
                                image24.hashCode),
                            image32.hashCode),
                        image48.hashCode),
                    image72.hashCode),
                image192.hashCode),
            image512.hashCode),
        team.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Profile')
          ..add('avatarHash', avatarHash)
          ..add('statusText', statusText)
          ..add('statusEmoji', statusEmoji)
          ..add('realName', realName)
          ..add('displayName', displayName)
          ..add('realNameNormalized', realNameNormalized)
          ..add('displayNameNormalized', displayNameNormalized)
          ..add('email', email)
          ..add('image24', image24)
          ..add('image32', image32)
          ..add('image48', image48)
          ..add('image72', image72)
          ..add('image192', image192)
          ..add('image512', image512)
          ..add('team', team))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile _$v;

  String _avatarHash;
  String get avatarHash => _$this._avatarHash;
  set avatarHash(String avatarHash) => _$this._avatarHash = avatarHash;

  String _statusText;
  String get statusText => _$this._statusText;
  set statusText(String statusText) => _$this._statusText = statusText;

  String _statusEmoji;
  String get statusEmoji => _$this._statusEmoji;
  set statusEmoji(String statusEmoji) => _$this._statusEmoji = statusEmoji;

  String _realName;
  String get realName => _$this._realName;
  set realName(String realName) => _$this._realName = realName;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _realNameNormalized;
  String get realNameNormalized => _$this._realNameNormalized;
  set realNameNormalized(String realNameNormalized) =>
      _$this._realNameNormalized = realNameNormalized;

  String _displayNameNormalized;
  String get displayNameNormalized => _$this._displayNameNormalized;
  set displayNameNormalized(String displayNameNormalized) =>
      _$this._displayNameNormalized = displayNameNormalized;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

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

  String _team;
  String get team => _$this._team;
  set team(String team) => _$this._team = team;

  ProfileBuilder();

  ProfileBuilder get _$this {
    if (_$v != null) {
      _avatarHash = _$v.avatarHash;
      _statusText = _$v.statusText;
      _statusEmoji = _$v.statusEmoji;
      _realName = _$v.realName;
      _displayName = _$v.displayName;
      _realNameNormalized = _$v.realNameNormalized;
      _displayNameNormalized = _$v.displayNameNormalized;
      _email = _$v.email;
      _image24 = _$v.image24;
      _image32 = _$v.image32;
      _image48 = _$v.image48;
      _image72 = _$v.image72;
      _image192 = _$v.image192;
      _image512 = _$v.image512;
      _team = _$v.team;
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
            avatarHash: avatarHash,
            statusText: statusText,
            statusEmoji: statusEmoji,
            realName: realName,
            displayName: displayName,
            realNameNormalized: realNameNormalized,
            displayNameNormalized: displayNameNormalized,
            email: email,
            image24: image24,
            image32: image32,
            image48: image48,
            image72: image72,
            image192: image192,
            image512: image512,
            team: team);
    replace(_$result);
    return _$result;
  }
}
