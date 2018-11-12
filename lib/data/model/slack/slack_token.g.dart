// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slack_token.dart';

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

Serializer<SlackToken> _$slackTokenSerializer = new _$SlackTokenSerializer();

class _$SlackTokenSerializer implements StructuredSerializer<SlackToken> {
  @override
  final Iterable<Type> types = const [SlackToken, _$SlackToken];
  @override
  final String wireName = 'SlackToken';

  @override
  Iterable serialize(Serializers serializers, SlackToken object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.accessToken != null) {
      result
        ..add('access_token')
        ..add(serializers.serialize(object.accessToken,
            specifiedType: const FullType(String)));
    }
    if (object.scope != null) {
      result
        ..add('scope')
        ..add(serializers.serialize(object.scope,
            specifiedType: const FullType(String)));
    }
    if (object.teamName != null) {
      result
        ..add('team_name')
        ..add(serializers.serialize(object.teamName,
            specifiedType: const FullType(String)));
    }
    if (object.teamId != null) {
      result
        ..add('team_id')
        ..add(serializers.serialize(object.teamId,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  SlackToken deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SlackTokenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'access_token':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'scope':
          result.scope = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'team_name':
          result.teamName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'team_id':
          result.teamId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SlackToken extends SlackToken {
  @override
  final String accessToken;
  @override
  final String scope;
  @override
  final String teamName;
  @override
  final String teamId;

  factory _$SlackToken([void updates(SlackTokenBuilder b)]) =>
      (new SlackTokenBuilder()..update(updates)).build();

  _$SlackToken._({this.accessToken, this.scope, this.teamName, this.teamId})
      : super._();

  @override
  SlackToken rebuild(void updates(SlackTokenBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SlackTokenBuilder toBuilder() => new SlackTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SlackToken &&
        accessToken == other.accessToken &&
        scope == other.scope &&
        teamName == other.teamName &&
        teamId == other.teamId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, accessToken.hashCode), scope.hashCode),
            teamName.hashCode),
        teamId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SlackToken')
          ..add('accessToken', accessToken)
          ..add('scope', scope)
          ..add('teamName', teamName)
          ..add('teamId', teamId))
        .toString();
  }
}

class SlackTokenBuilder implements Builder<SlackToken, SlackTokenBuilder> {
  _$SlackToken _$v;

  String _accessToken;
  String get accessToken => _$this._accessToken;
  set accessToken(String accessToken) => _$this._accessToken = accessToken;

  String _scope;
  String get scope => _$this._scope;
  set scope(String scope) => _$this._scope = scope;

  String _teamName;
  String get teamName => _$this._teamName;
  set teamName(String teamName) => _$this._teamName = teamName;

  String _teamId;
  String get teamId => _$this._teamId;
  set teamId(String teamId) => _$this._teamId = teamId;

  SlackTokenBuilder();

  SlackTokenBuilder get _$this {
    if (_$v != null) {
      _accessToken = _$v.accessToken;
      _scope = _$v.scope;
      _teamName = _$v.teamName;
      _teamId = _$v.teamId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SlackToken other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SlackToken;
  }

  @override
  void update(void updates(SlackTokenBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SlackToken build() {
    final _$result = _$v ??
        new _$SlackToken._(
            accessToken: accessToken,
            scope: scope,
            teamName: teamName,
            teamId: teamId);
    replace(_$result);
    return _$result;
  }
}
