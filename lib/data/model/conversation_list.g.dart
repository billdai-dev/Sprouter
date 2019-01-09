// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ConversationList> _$conversationListSerializer =
    new _$ConversationListSerializer();
Serializer<Channel> _$channelSerializer = new _$ChannelSerializer();
Serializer<ResponseMetadata> _$responseMetadataSerializer =
    new _$ResponseMetadataSerializer();

class _$ConversationListSerializer
    implements StructuredSerializer<ConversationList> {
  @override
  final Iterable<Type> types = const [ConversationList, _$ConversationList];
  @override
  final String wireName = 'ConversationList';

  @override
  Iterable serialize(Serializers serializers, ConversationList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.ok != null) {
      result
        ..add('ok')
        ..add(serializers.serialize(object.ok,
            specifiedType: const FullType(bool)));
    }
    if (object.channels != null) {
      result
        ..add('channels')
        ..add(serializers.serialize(object.channels,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Channel)])));
    }
    if (object.responseMetadata != null) {
      result
        ..add('response_metadata')
        ..add(serializers.serialize(object.responseMetadata,
            specifiedType: const FullType(ResponseMetadata)));
    }

    return result;
  }

  @override
  ConversationList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConversationListBuilder();

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
        case 'channels':
          result.channels.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Channel)])) as BuiltList);
          break;
        case 'response_metadata':
          result.responseMetadata.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ResponseMetadata))
              as ResponseMetadata);
          break;
      }
    }

    return result.build();
  }
}

class _$ChannelSerializer implements StructuredSerializer<Channel> {
  @override
  final Iterable<Type> types = const [Channel, _$Channel];
  @override
  final String wireName = 'Channel';

  @override
  Iterable serialize(Serializers serializers, Channel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.created != null) {
      result
        ..add('created')
        ..add(serializers.serialize(object.created,
            specifiedType: const FullType(int)));
    }
    if (object.isIm != null) {
      result
        ..add('is_im')
        ..add(serializers.serialize(object.isIm,
            specifiedType: const FullType(bool)));
    }
    if (object.isOrgShared != null) {
      result
        ..add('is_org_shared')
        ..add(serializers.serialize(object.isOrgShared,
            specifiedType: const FullType(bool)));
    }
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(String)));
    }
    if (object.isUserDeleted != null) {
      result
        ..add('is_user_deleted')
        ..add(serializers.serialize(object.isUserDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.priority != null) {
      result
        ..add('priority')
        ..add(serializers.serialize(object.priority,
            specifiedType: const FullType(double)));
    }

    return result;
  }

  @override
  Channel deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChannelBuilder();

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
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_im':
          result.isIm = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_org_shared':
          result.isOrgShared = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_user_deleted':
          result.isUserDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'priority':
          result.priority = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$ResponseMetadataSerializer
    implements StructuredSerializer<ResponseMetadata> {
  @override
  final Iterable<Type> types = const [ResponseMetadata, _$ResponseMetadata];
  @override
  final String wireName = 'ResponseMetadata';

  @override
  Iterable serialize(Serializers serializers, ResponseMetadata object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.nextCursor != null) {
      result
        ..add('next_cursor')
        ..add(serializers.serialize(object.nextCursor,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  ResponseMetadata deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ResponseMetadataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'next_cursor':
          result.nextCursor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ConversationList extends ConversationList {
  @override
  final bool ok;
  @override
  final BuiltList<Channel> channels;
  @override
  final ResponseMetadata responseMetadata;

  factory _$ConversationList([void updates(ConversationListBuilder b)]) =>
      (new ConversationListBuilder()..update(updates)).build();

  _$ConversationList._({this.ok, this.channels, this.responseMetadata})
      : super._();

  @override
  ConversationList rebuild(void updates(ConversationListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ConversationListBuilder toBuilder() =>
      new ConversationListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConversationList &&
        ok == other.ok &&
        channels == other.channels &&
        responseMetadata == other.responseMetadata;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, ok.hashCode), channels.hashCode),
        responseMetadata.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConversationList')
          ..add('ok', ok)
          ..add('channels', channels)
          ..add('responseMetadata', responseMetadata))
        .toString();
  }
}

class ConversationListBuilder
    implements Builder<ConversationList, ConversationListBuilder> {
  _$ConversationList _$v;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  ListBuilder<Channel> _channels;
  ListBuilder<Channel> get channels =>
      _$this._channels ??= new ListBuilder<Channel>();
  set channels(ListBuilder<Channel> channels) => _$this._channels = channels;

  ResponseMetadataBuilder _responseMetadata;
  ResponseMetadataBuilder get responseMetadata =>
      _$this._responseMetadata ??= new ResponseMetadataBuilder();
  set responseMetadata(ResponseMetadataBuilder responseMetadata) =>
      _$this._responseMetadata = responseMetadata;

  ConversationListBuilder();

  ConversationListBuilder get _$this {
    if (_$v != null) {
      _ok = _$v.ok;
      _channels = _$v.channels?.toBuilder();
      _responseMetadata = _$v.responseMetadata?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConversationList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ConversationList;
  }

  @override
  void update(void updates(ConversationListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ConversationList build() {
    _$ConversationList _$result;
    try {
      _$result = _$v ??
          new _$ConversationList._(
              ok: ok,
              channels: _channels?.build(),
              responseMetadata: _responseMetadata?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'channels';
        _channels?.build();
        _$failedField = 'responseMetadata';
        _responseMetadata?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ConversationList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Channel extends Channel {
  @override
  final String id;
  @override
  final int created;
  @override
  final bool isIm;
  @override
  final bool isOrgShared;
  @override
  final String user;
  @override
  final bool isUserDeleted;
  @override
  final double priority;

  factory _$Channel([void updates(ChannelBuilder b)]) =>
      (new ChannelBuilder()..update(updates)).build();

  _$Channel._(
      {this.id,
      this.created,
      this.isIm,
      this.isOrgShared,
      this.user,
      this.isUserDeleted,
      this.priority})
      : super._();

  @override
  Channel rebuild(void updates(ChannelBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ChannelBuilder toBuilder() => new ChannelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Channel &&
        id == other.id &&
        created == other.created &&
        isIm == other.isIm &&
        isOrgShared == other.isOrgShared &&
        user == other.user &&
        isUserDeleted == other.isUserDeleted &&
        priority == other.priority;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), created.hashCode),
                        isIm.hashCode),
                    isOrgShared.hashCode),
                user.hashCode),
            isUserDeleted.hashCode),
        priority.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Channel')
          ..add('id', id)
          ..add('created', created)
          ..add('isIm', isIm)
          ..add('isOrgShared', isOrgShared)
          ..add('user', user)
          ..add('isUserDeleted', isUserDeleted)
          ..add('priority', priority))
        .toString();
  }
}

class ChannelBuilder implements Builder<Channel, ChannelBuilder> {
  _$Channel _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _created;
  int get created => _$this._created;
  set created(int created) => _$this._created = created;

  bool _isIm;
  bool get isIm => _$this._isIm;
  set isIm(bool isIm) => _$this._isIm = isIm;

  bool _isOrgShared;
  bool get isOrgShared => _$this._isOrgShared;
  set isOrgShared(bool isOrgShared) => _$this._isOrgShared = isOrgShared;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  bool _isUserDeleted;
  bool get isUserDeleted => _$this._isUserDeleted;
  set isUserDeleted(bool isUserDeleted) =>
      _$this._isUserDeleted = isUserDeleted;

  double _priority;
  double get priority => _$this._priority;
  set priority(double priority) => _$this._priority = priority;

  ChannelBuilder();

  ChannelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _created = _$v.created;
      _isIm = _$v.isIm;
      _isOrgShared = _$v.isOrgShared;
      _user = _$v.user;
      _isUserDeleted = _$v.isUserDeleted;
      _priority = _$v.priority;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Channel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Channel;
  }

  @override
  void update(void updates(ChannelBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Channel build() {
    final _$result = _$v ??
        new _$Channel._(
            id: id,
            created: created,
            isIm: isIm,
            isOrgShared: isOrgShared,
            user: user,
            isUserDeleted: isUserDeleted,
            priority: priority);
    replace(_$result);
    return _$result;
  }
}

class _$ResponseMetadata extends ResponseMetadata {
  @override
  final String nextCursor;

  factory _$ResponseMetadata([void updates(ResponseMetadataBuilder b)]) =>
      (new ResponseMetadataBuilder()..update(updates)).build();

  _$ResponseMetadata._({this.nextCursor}) : super._();

  @override
  ResponseMetadata rebuild(void updates(ResponseMetadataBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ResponseMetadataBuilder toBuilder() =>
      new ResponseMetadataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResponseMetadata && nextCursor == other.nextCursor;
  }

  @override
  int get hashCode {
    return $jf($jc(0, nextCursor.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ResponseMetadata')
          ..add('nextCursor', nextCursor))
        .toString();
  }
}

class ResponseMetadataBuilder
    implements Builder<ResponseMetadata, ResponseMetadataBuilder> {
  _$ResponseMetadata _$v;

  String _nextCursor;
  String get nextCursor => _$this._nextCursor;
  set nextCursor(String nextCursor) => _$this._nextCursor = nextCursor;

  ResponseMetadataBuilder();

  ResponseMetadataBuilder get _$this {
    if (_$v != null) {
      _nextCursor = _$v.nextCursor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResponseMetadata other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ResponseMetadata;
  }

  @override
  void update(void updates(ResponseMetadataBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ResponseMetadata build() {
    final _$result = _$v ?? new _$ResponseMetadata._(nextCursor: nextCursor);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
