// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_message.dart';

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

Serializer<PostMessageRequest> _$postMessageRequestSerializer =
    new _$PostMessageRequestSerializer();
Serializer<PostMessageResponse> _$postMessageResponseSerializer =
    new _$PostMessageResponseSerializer();

class _$PostMessageRequestSerializer
    implements StructuredSerializer<PostMessageRequest> {
  @override
  final Iterable<Type> types = const [PostMessageRequest, _$PostMessageRequest];
  @override
  final String wireName = 'PostMessageRequest';

  @override
  Iterable serialize(Serializers serializers, PostMessageRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'channel',
      serializers.serialize(object.channel,
          specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'as_user',
      serializers.serialize(object.asUser, specifiedType: const FullType(bool)),
    ];
    if (object.threadTs != null) {
      result
        ..add('thread_ts')
        ..add(serializers.serialize(object.threadTs,
            specifiedType: const FullType(String)));
    }
    if (object.ts != null) {
      result
        ..add('ts')
        ..add(serializers.serialize(object.ts,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  PostMessageRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PostMessageRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'channel':
          result.channel = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'as_user':
          result.asUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'thread_ts':
          result.threadTs = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ts':
          result.ts = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PostMessageResponseSerializer
    implements StructuredSerializer<PostMessageResponse> {
  @override
  final Iterable<Type> types = const [
    PostMessageResponse,
    _$PostMessageResponse
  ];
  @override
  final String wireName = 'PostMessageResponse';

  @override
  Iterable serialize(Serializers serializers, PostMessageResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ok',
      serializers.serialize(object.ok, specifiedType: const FullType(bool)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(Message)),
    ];
    if (object.channel != null) {
      result
        ..add('channel')
        ..add(serializers.serialize(object.channel,
            specifiedType: const FullType(String)));
    }
    if (object.ts != null) {
      result
        ..add('ts')
        ..add(serializers.serialize(object.ts,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  PostMessageResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PostMessageResponseBuilder();

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
        case 'channel':
          result.channel = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ts':
          result.ts = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message.replace(serializers.deserialize(value,
              specifiedType: const FullType(Message)) as Message);
          break;
      }
    }

    return result.build();
  }
}

class _$PostMessageRequest extends PostMessageRequest {
  @override
  final String channel;
  @override
  final String text;
  @override
  final bool asUser;
  @override
  final String threadTs;
  @override
  final String ts;

  factory _$PostMessageRequest([void updates(PostMessageRequestBuilder b)]) =>
      (new PostMessageRequestBuilder()..update(updates)).build();

  _$PostMessageRequest._(
      {this.channel, this.text, this.asUser, this.threadTs, this.ts})
      : super._() {
    if (channel == null) {
      throw new BuiltValueNullFieldError('PostMessageRequest', 'channel');
    }
    if (text == null) {
      throw new BuiltValueNullFieldError('PostMessageRequest', 'text');
    }
    if (asUser == null) {
      throw new BuiltValueNullFieldError('PostMessageRequest', 'asUser');
    }
  }

  @override
  PostMessageRequest rebuild(void updates(PostMessageRequestBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PostMessageRequestBuilder toBuilder() =>
      new PostMessageRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostMessageRequest &&
        channel == other.channel &&
        text == other.text &&
        asUser == other.asUser &&
        threadTs == other.threadTs &&
        ts == other.ts;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, channel.hashCode), text.hashCode), asUser.hashCode),
            threadTs.hashCode),
        ts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PostMessageRequest')
          ..add('channel', channel)
          ..add('text', text)
          ..add('asUser', asUser)
          ..add('threadTs', threadTs)
          ..add('ts', ts))
        .toString();
  }
}

class PostMessageRequestBuilder
    implements Builder<PostMessageRequest, PostMessageRequestBuilder> {
  _$PostMessageRequest _$v;

  String _channel;
  String get channel => _$this._channel;
  set channel(String channel) => _$this._channel = channel;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  bool _asUser;
  bool get asUser => _$this._asUser;
  set asUser(bool asUser) => _$this._asUser = asUser;

  String _threadTs;
  String get threadTs => _$this._threadTs;
  set threadTs(String threadTs) => _$this._threadTs = threadTs;

  String _ts;
  String get ts => _$this._ts;
  set ts(String ts) => _$this._ts = ts;

  PostMessageRequestBuilder();

  PostMessageRequestBuilder get _$this {
    if (_$v != null) {
      _channel = _$v.channel;
      _text = _$v.text;
      _asUser = _$v.asUser;
      _threadTs = _$v.threadTs;
      _ts = _$v.ts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostMessageRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PostMessageRequest;
  }

  @override
  void update(void updates(PostMessageRequestBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PostMessageRequest build() {
    final _$result = _$v ??
        new _$PostMessageRequest._(
            channel: channel,
            text: text,
            asUser: asUser,
            threadTs: threadTs,
            ts: ts);
    replace(_$result);
    return _$result;
  }
}

class _$PostMessageResponse extends PostMessageResponse {
  @override
  final bool ok;
  @override
  final String channel;
  @override
  final String ts;
  @override
  final Message message;

  factory _$PostMessageResponse([void updates(PostMessageResponseBuilder b)]) =>
      (new PostMessageResponseBuilder()..update(updates)).build();

  _$PostMessageResponse._({this.ok, this.channel, this.ts, this.message})
      : super._() {
    if (ok == null) {
      throw new BuiltValueNullFieldError('PostMessageResponse', 'ok');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('PostMessageResponse', 'message');
    }
  }

  @override
  PostMessageResponse rebuild(void updates(PostMessageResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PostMessageResponseBuilder toBuilder() =>
      new PostMessageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostMessageResponse &&
        ok == other.ok &&
        channel == other.channel &&
        ts == other.ts &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, ok.hashCode), channel.hashCode), ts.hashCode),
        message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PostMessageResponse')
          ..add('ok', ok)
          ..add('channel', channel)
          ..add('ts', ts)
          ..add('message', message))
        .toString();
  }
}

class PostMessageResponseBuilder
    implements Builder<PostMessageResponse, PostMessageResponseBuilder> {
  _$PostMessageResponse _$v;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  String _channel;
  String get channel => _$this._channel;
  set channel(String channel) => _$this._channel = channel;

  String _ts;
  String get ts => _$this._ts;
  set ts(String ts) => _$this._ts = ts;

  MessageBuilder _message;
  MessageBuilder get message => _$this._message ??= new MessageBuilder();
  set message(MessageBuilder message) => _$this._message = message;

  PostMessageResponseBuilder();

  PostMessageResponseBuilder get _$this {
    if (_$v != null) {
      _ok = _$v.ok;
      _channel = _$v.channel;
      _ts = _$v.ts;
      _message = _$v.message?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostMessageResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PostMessageResponse;
  }

  @override
  void update(void updates(PostMessageResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PostMessageResponse build() {
    _$PostMessageResponse _$result;
    try {
      _$result = _$v ??
          new _$PostMessageResponse._(
              ok: ok, channel: channel, ts: ts, message: message.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'message';
        message.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PostMessageResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
