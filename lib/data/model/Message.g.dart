// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<Message> _$messageSerializer = new _$MessageSerializer();
Serializer<Messages> _$messagesSerializer = new _$MessagesSerializer();
Serializer<Reply> _$replySerializer = new _$ReplySerializer();

class _$MessageSerializer implements StructuredSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];
  @override
  final String wireName = 'Message';

  @override
  Iterable serialize(Serializers serializers, Message object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'messages',
      serializers.serialize(object.messages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Messages)])),
      'has_more',
      serializers.serialize(object.hasMore,
          specifiedType: const FullType(bool)),
      'ok',
      serializers.serialize(object.ok, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Message deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new MessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'messages':
          result.messages.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Messages)])) as BuiltList);
          break;
        case 'has_more':
          result.hasMore = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'ok':
          result.ok = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$MessagesSerializer implements StructuredSerializer<Messages> {
  @override
  final Iterable<Type> types = const [Messages, _$Messages];
  @override
  final String wireName = 'Messages';

  @override
  Iterable serialize(Serializers serializers, Messages object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'client_msg_id',
      serializers.serialize(object.clientMsgId,
          specifiedType: const FullType(String)),
      'thread_ts',
      serializers.serialize(object.threadTs,
          specifiedType: const FullType(String)),
      'reply_count',
      serializers.serialize(object.replyCount,
          specifiedType: const FullType(int)),
      'replies',
      serializers.serialize(object.replies,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Reply)])),
      'subscribed',
      serializers.serialize(object.subscribed,
          specifiedType: const FullType(bool)),
      'last_read',
      serializers.serialize(object.lastRead,
          specifiedType: const FullType(String)),
      'unread_count',
      serializers.serialize(object.unreadCount,
          specifiedType: const FullType(int)),
      'ts',
      serializers.serialize(object.ts, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Messages deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new MessagesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_msg_id':
          result.clientMsgId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thread_ts':
          result.threadTs = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reply_count':
          result.replyCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'replies':
          result.replies.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Reply)]))
              as BuiltList);
          break;
        case 'subscribed':
          result.subscribed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'last_read':
          result.lastRead = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'unread_count':
          result.unreadCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$ReplySerializer implements StructuredSerializer<Reply> {
  @override
  final Iterable<Type> types = const [Reply, _$Reply];
  @override
  final String wireName = 'Reply';

  @override
  Iterable serialize(Serializers serializers, Reply object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'ts',
      serializers.serialize(object.ts, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Reply deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ReplyBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'user':
          result.user = serializers.deserialize(value,
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

class _$Message extends Message {
  @override
  final BuiltList<Messages> messages;
  @override
  final bool hasMore;
  @override
  final bool ok;

  factory _$Message([void updates(MessageBuilder b)]) =>
      (new MessageBuilder()..update(updates)).build();

  _$Message._({this.messages, this.hasMore, this.ok}) : super._() {
    if (messages == null)
      throw new BuiltValueNullFieldError('Message', 'messages');
    if (hasMore == null)
      throw new BuiltValueNullFieldError('Message', 'hasMore');
    if (ok == null) throw new BuiltValueNullFieldError('Message', 'ok');
  }

  @override
  Message rebuild(void updates(MessageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => new MessageBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Message) return false;
    return messages == other.messages &&
        hasMore == other.hasMore &&
        ok == other.ok;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, messages.hashCode), hasMore.hashCode), ok.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Message')
          ..add('messages', messages)
          ..add('hasMore', hasMore)
          ..add('ok', ok))
        .toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message _$v;

  ListBuilder<Messages> _messages;
  ListBuilder<Messages> get messages =>
      _$this._messages ??= new ListBuilder<Messages>();
  set messages(ListBuilder<Messages> messages) => _$this._messages = messages;

  bool _hasMore;
  bool get hasMore => _$this._hasMore;
  set hasMore(bool hasMore) => _$this._hasMore = hasMore;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  MessageBuilder();

  MessageBuilder get _$this {
    if (_$v != null) {
      _messages = _$v.messages?.toBuilder();
      _hasMore = _$v.hasMore;
      _ok = _$v.ok;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Message other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Message;
  }

  @override
  void update(void updates(MessageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Message build() {
    _$Message _$result;
    try {
      _$result = _$v ??
          new _$Message._(messages: messages.build(), hasMore: hasMore, ok: ok);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'messages';
        messages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Message', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Messages extends Messages {
  @override
  final String type;
  @override
  final String user;
  @override
  final String text;
  @override
  final String clientMsgId;
  @override
  final String threadTs;
  @override
  final int replyCount;
  @override
  final BuiltList<Reply> replies;
  @override
  final bool subscribed;
  @override
  final String lastRead;
  @override
  final int unreadCount;
  @override
  final String ts;

  factory _$Messages([void updates(MessagesBuilder b)]) =>
      (new MessagesBuilder()..update(updates)).build();

  _$Messages._(
      {this.type,
      this.user,
      this.text,
      this.clientMsgId,
      this.threadTs,
      this.replyCount,
      this.replies,
      this.subscribed,
      this.lastRead,
      this.unreadCount,
      this.ts})
      : super._() {
    if (type == null) throw new BuiltValueNullFieldError('Messages', 'type');
    if (user == null) throw new BuiltValueNullFieldError('Messages', 'user');
    if (text == null) throw new BuiltValueNullFieldError('Messages', 'text');
    if (clientMsgId == null)
      throw new BuiltValueNullFieldError('Messages', 'clientMsgId');
    if (threadTs == null)
      throw new BuiltValueNullFieldError('Messages', 'threadTs');
    if (replyCount == null)
      throw new BuiltValueNullFieldError('Messages', 'replyCount');
    if (replies == null)
      throw new BuiltValueNullFieldError('Messages', 'replies');
    if (subscribed == null)
      throw new BuiltValueNullFieldError('Messages', 'subscribed');
    if (lastRead == null)
      throw new BuiltValueNullFieldError('Messages', 'lastRead');
    if (unreadCount == null)
      throw new BuiltValueNullFieldError('Messages', 'unreadCount');
    if (ts == null) throw new BuiltValueNullFieldError('Messages', 'ts');
  }

  @override
  Messages rebuild(void updates(MessagesBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MessagesBuilder toBuilder() => new MessagesBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Messages) return false;
    return type == other.type &&
        user == other.user &&
        text == other.text &&
        clientMsgId == other.clientMsgId &&
        threadTs == other.threadTs &&
        replyCount == other.replyCount &&
        replies == other.replies &&
        subscribed == other.subscribed &&
        lastRead == other.lastRead &&
        unreadCount == other.unreadCount &&
        ts == other.ts;
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
                                        $jc($jc(0, type.hashCode),
                                            user.hashCode),
                                        text.hashCode),
                                    clientMsgId.hashCode),
                                threadTs.hashCode),
                            replyCount.hashCode),
                        replies.hashCode),
                    subscribed.hashCode),
                lastRead.hashCode),
            unreadCount.hashCode),
        ts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Messages')
          ..add('type', type)
          ..add('user', user)
          ..add('text', text)
          ..add('clientMsgId', clientMsgId)
          ..add('threadTs', threadTs)
          ..add('replyCount', replyCount)
          ..add('replies', replies)
          ..add('subscribed', subscribed)
          ..add('lastRead', lastRead)
          ..add('unreadCount', unreadCount)
          ..add('ts', ts))
        .toString();
  }
}

class MessagesBuilder implements Builder<Messages, MessagesBuilder> {
  _$Messages _$v;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  String _clientMsgId;
  String get clientMsgId => _$this._clientMsgId;
  set clientMsgId(String clientMsgId) => _$this._clientMsgId = clientMsgId;

  String _threadTs;
  String get threadTs => _$this._threadTs;
  set threadTs(String threadTs) => _$this._threadTs = threadTs;

  int _replyCount;
  int get replyCount => _$this._replyCount;
  set replyCount(int replyCount) => _$this._replyCount = replyCount;

  ListBuilder<Reply> _replies;
  ListBuilder<Reply> get replies =>
      _$this._replies ??= new ListBuilder<Reply>();
  set replies(ListBuilder<Reply> replies) => _$this._replies = replies;

  bool _subscribed;
  bool get subscribed => _$this._subscribed;
  set subscribed(bool subscribed) => _$this._subscribed = subscribed;

  String _lastRead;
  String get lastRead => _$this._lastRead;
  set lastRead(String lastRead) => _$this._lastRead = lastRead;

  int _unreadCount;
  int get unreadCount => _$this._unreadCount;
  set unreadCount(int unreadCount) => _$this._unreadCount = unreadCount;

  String _ts;
  String get ts => _$this._ts;
  set ts(String ts) => _$this._ts = ts;

  MessagesBuilder();

  MessagesBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _user = _$v.user;
      _text = _$v.text;
      _clientMsgId = _$v.clientMsgId;
      _threadTs = _$v.threadTs;
      _replyCount = _$v.replyCount;
      _replies = _$v.replies?.toBuilder();
      _subscribed = _$v.subscribed;
      _lastRead = _$v.lastRead;
      _unreadCount = _$v.unreadCount;
      _ts = _$v.ts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Messages other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Messages;
  }

  @override
  void update(void updates(MessagesBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Messages build() {
    _$Messages _$result;
    try {
      _$result = _$v ??
          new _$Messages._(
              type: type,
              user: user,
              text: text,
              clientMsgId: clientMsgId,
              threadTs: threadTs,
              replyCount: replyCount,
              replies: replies.build(),
              subscribed: subscribed,
              lastRead: lastRead,
              unreadCount: unreadCount,
              ts: ts);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'replies';
        replies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Messages', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Reply extends Reply {
  @override
  final String user;
  @override
  final String ts;

  factory _$Reply([void updates(ReplyBuilder b)]) =>
      (new ReplyBuilder()..update(updates)).build();

  _$Reply._({this.user, this.ts}) : super._() {
    if (user == null) throw new BuiltValueNullFieldError('Reply', 'user');
    if (ts == null) throw new BuiltValueNullFieldError('Reply', 'ts');
  }

  @override
  Reply rebuild(void updates(ReplyBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplyBuilder toBuilder() => new ReplyBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Reply) return false;
    return user == other.user && ts == other.ts;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, user.hashCode), ts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Reply')
          ..add('user', user)
          ..add('ts', ts))
        .toString();
  }
}

class ReplyBuilder implements Builder<Reply, ReplyBuilder> {
  _$Reply _$v;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  String _ts;
  String get ts => _$this._ts;
  set ts(String ts) => _$this._ts = ts;

  ReplyBuilder();

  ReplyBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user;
      _ts = _$v.ts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Reply other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Reply;
  }

  @override
  void update(void updates(ReplyBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Reply build() {
    final _$result = _$v ?? new _$Reply._(user: user, ts: ts);
    replace(_$result);
    return _$result;
  }
}
