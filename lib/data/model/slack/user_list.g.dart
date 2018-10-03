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
