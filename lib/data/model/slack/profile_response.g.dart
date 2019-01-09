// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProfileResponse> _$profileResponseSerializer =
    new _$ProfileResponseSerializer();
Serializer<User> _$userSerializer = new _$UserSerializer();
Serializer<Team> _$teamSerializer = new _$TeamSerializer();

class _$ProfileResponseSerializer
    implements StructuredSerializer<ProfileResponse> {
  @override
  final Iterable<Type> types = const [ProfileResponse, _$ProfileResponse];
  @override
  final String wireName = 'ProfileResponse';

  @override
  Iterable serialize(Serializers serializers, ProfileResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ok',
      serializers.serialize(object.ok, specifiedType: const FullType(bool)),
    ];
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(User)));
    }
    if (object.profile != null) {
      result
        ..add('profile')
        ..add(serializers.serialize(object.profile,
            specifiedType: const FullType(Profile)));
    }

    return result;
  }

  @override
  ProfileResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileResponseBuilder();

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
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'profile':
          result.profile.replace(serializers.deserialize(value,
              specifiedType: const FullType(Profile)) as Profile);
          break;
      }
    }

    return result.build();
  }
}

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
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

    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
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
      }
    }

    return result.build();
  }
}

class _$TeamSerializer implements StructuredSerializer<Team> {
  @override
  final Iterable<Type> types = const [Team, _$Team];
  @override
  final String wireName = 'Team';

  @override
  Iterable serialize(Serializers serializers, Team object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Team deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TeamBuilder();

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
      }
    }

    return result.build();
  }
}

class _$ProfileResponse extends ProfileResponse {
  @override
  final bool ok;
  @override
  final User user;
  @override
  final Profile profile;

  factory _$ProfileResponse([void updates(ProfileResponseBuilder b)]) =>
      (new ProfileResponseBuilder()..update(updates)).build();

  _$ProfileResponse._({this.ok, this.user, this.profile}) : super._() {
    if (ok == null) {
      throw new BuiltValueNullFieldError('ProfileResponse', 'ok');
    }
  }

  @override
  ProfileResponse rebuild(void updates(ProfileResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileResponseBuilder toBuilder() =>
      new ProfileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileResponse &&
        ok == other.ok &&
        user == other.user &&
        profile == other.profile;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, ok.hashCode), user.hashCode), profile.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProfileResponse')
          ..add('ok', ok)
          ..add('user', user)
          ..add('profile', profile))
        .toString();
  }
}

class ProfileResponseBuilder
    implements Builder<ProfileResponse, ProfileResponseBuilder> {
  _$ProfileResponse _$v;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  ProfileBuilder _profile;
  ProfileBuilder get profile => _$this._profile ??= new ProfileBuilder();
  set profile(ProfileBuilder profile) => _$this._profile = profile;

  ProfileResponseBuilder();

  ProfileResponseBuilder get _$this {
    if (_$v != null) {
      _ok = _$v.ok;
      _user = _$v.user?.toBuilder();
      _profile = _$v.profile?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProfileResponse;
  }

  @override
  void update(void updates(ProfileResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ProfileResponse build() {
    _$ProfileResponse _$result;
    try {
      _$result = _$v ??
          new _$ProfileResponse._(
              ok: ok, user: _user?.build(), profile: _profile?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'profile';
        _profile?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProfileResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$User extends User {
  @override
  final String name;
  @override
  final String id;
  @override
  final String image24;
  @override
  final String image32;
  @override
  final String image48;
  @override
  final String image72;

  factory _$User([void updates(UserBuilder b)]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.name,
      this.id,
      this.image24,
      this.image32,
      this.image48,
      this.image72})
      : super._();

  @override
  User rebuild(void updates(UserBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        name == other.name &&
        id == other.id &&
        image24 == other.image24 &&
        image32 == other.image32 &&
        image48 == other.image48 &&
        image72 == other.image72;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, name.hashCode), id.hashCode), image24.hashCode),
                image32.hashCode),
            image48.hashCode),
        image72.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('name', name)
          ..add('id', id)
          ..add('image24', image24)
          ..add('image32', image32)
          ..add('image48', image48)
          ..add('image72', image72))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

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

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _id = _$v.id;
      _image24 = _$v.image24;
      _image32 = _$v.image32;
      _image48 = _$v.image48;
      _image72 = _$v.image72;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void updates(UserBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            name: name,
            id: id,
            image24: image24,
            image32: image32,
            image48: image48,
            image72: image72);
    replace(_$result);
    return _$result;
  }
}

class _$Team extends Team {
  @override
  final String id;

  factory _$Team([void updates(TeamBuilder b)]) =>
      (new TeamBuilder()..update(updates)).build();

  _$Team._({this.id}) : super._();

  @override
  Team rebuild(void updates(TeamBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TeamBuilder toBuilder() => new TeamBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Team && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Team')..add('id', id)).toString();
  }
}

class TeamBuilder implements Builder<Team, TeamBuilder> {
  _$Team _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  TeamBuilder();

  TeamBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Team other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Team;
  }

  @override
  void update(void updates(TeamBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Team build() {
    final _$result = _$v ?? new _$Team._(id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
