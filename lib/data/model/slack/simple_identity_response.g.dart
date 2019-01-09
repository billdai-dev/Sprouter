// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_identity_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SimpleIdentityResponse> _$simpleIdentityResponseSerializer =
    new _$SimpleIdentityResponseSerializer();

class _$SimpleIdentityResponseSerializer
    implements StructuredSerializer<SimpleIdentityResponse> {
  @override
  final Iterable<Type> types = const [
    SimpleIdentityResponse,
    _$SimpleIdentityResponse
  ];
  @override
  final String wireName = 'SimpleIdentityResponse';

  @override
  Iterable serialize(Serializers serializers, SimpleIdentityResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ok',
      serializers.serialize(object.ok, specifiedType: const FullType(bool)),
    ];
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(String)));
    }
    if (object.userId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.userId,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  SimpleIdentityResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SimpleIdentityResponseBuilder();

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
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SimpleIdentityResponse extends SimpleIdentityResponse {
  @override
  final bool ok;
  @override
  final String user;
  @override
  final String userId;

  factory _$SimpleIdentityResponse(
          [void updates(SimpleIdentityResponseBuilder b)]) =>
      (new SimpleIdentityResponseBuilder()..update(updates)).build();

  _$SimpleIdentityResponse._({this.ok, this.user, this.userId}) : super._() {
    if (ok == null) {
      throw new BuiltValueNullFieldError('SimpleIdentityResponse', 'ok');
    }
  }

  @override
  SimpleIdentityResponse rebuild(
          void updates(SimpleIdentityResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SimpleIdentityResponseBuilder toBuilder() =>
      new SimpleIdentityResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SimpleIdentityResponse &&
        ok == other.ok &&
        user == other.user &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, ok.hashCode), user.hashCode), userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SimpleIdentityResponse')
          ..add('ok', ok)
          ..add('user', user)
          ..add('userId', userId))
        .toString();
  }
}

class SimpleIdentityResponseBuilder
    implements Builder<SimpleIdentityResponse, SimpleIdentityResponseBuilder> {
  _$SimpleIdentityResponse _$v;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  SimpleIdentityResponseBuilder();

  SimpleIdentityResponseBuilder get _$this {
    if (_$v != null) {
      _ok = _$v.ok;
      _user = _$v.user;
      _userId = _$v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SimpleIdentityResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SimpleIdentityResponse;
  }

  @override
  void update(void updates(SimpleIdentityResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SimpleIdentityResponse build() {
    final _$result = _$v ??
        new _$SimpleIdentityResponse._(ok: ok, user: user, userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
