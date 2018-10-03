// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

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

Serializer<UserProfileResponse> _$userProfileSerializer =
    new _$UserProfileSerializer();

class _$UserProfileSerializer
    implements StructuredSerializer<UserProfileResponse> {
  @override
  final Iterable<Type> types = const [UserProfileResponse, _$UserProfile];
  @override
  final String wireName = 'UserProfile';

  @override
  Iterable serialize(Serializers serializers, UserProfileResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.ok != null) {
      result
        ..add('ok')
        ..add(serializers.serialize(object.ok,
            specifiedType: const FullType(bool)));
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
  UserProfileResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserProfileBuilder();

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
        case 'profile':
          result.profile.replace(serializers.deserialize(value,
              specifiedType: const FullType(Profile)) as Profile);
          break;
      }
    }

    return result.build();
  }
}

class _$UserProfile extends UserProfileResponse {
  @override
  final bool ok;
  @override
  final Profile profile;

  factory _$UserProfile([void updates(UserProfileBuilder b)]) =>
      (new UserProfileBuilder()..update(updates)).build();

  _$UserProfile._({this.ok, this.profile}) : super._();

  @override
  UserProfileResponse rebuild(void updates(UserProfileBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserProfileBuilder toBuilder() => new UserProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfileResponse &&
        ok == other.ok &&
        profile == other.profile;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, ok.hashCode), profile.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserProfile')
          ..add('ok', ok)
          ..add('profile', profile))
        .toString();
  }
}

class UserProfileBuilder
    implements Builder<UserProfileResponse, UserProfileBuilder> {
  _$UserProfile _$v;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  ProfileBuilder _profile;
  ProfileBuilder get profile => _$this._profile ??= new ProfileBuilder();
  set profile(ProfileBuilder profile) => _$this._profile = profile;

  UserProfileBuilder();

  UserProfileBuilder get _$this {
    if (_$v != null) {
      _ok = _$v.ok;
      _profile = _$v.profile?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfileResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserProfile;
  }

  @override
  void update(void updates(UserProfileBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserProfile build() {
    _$UserProfile _$result;
    try {
      _$result = _$v ?? new _$UserProfile._(ok: ok, profile: _profile?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'profile';
        _profile?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserProfile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
