// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

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

Serializer<Message> _$messageSerializer = new _$MessageSerializer();
Serializer<Reply> _$replySerializer = new _$ReplySerializer();
Serializer<File> _$fileSerializer = new _$FileSerializer();

class _$MessageSerializer implements StructuredSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];
  @override
  final String wireName = 'Message';

  @override
  Iterable serialize(Serializers serializers, Message object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(String)));
    }
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(String)));
    }
    if (object.text != null) {
      result
        ..add('text')
        ..add(serializers.serialize(object.text,
            specifiedType: const FullType(String)));
    }
    if (object.clientMsgId != null) {
      result
        ..add('client_msg_id')
        ..add(serializers.serialize(object.clientMsgId,
            specifiedType: const FullType(String)));
    }
    if (object.threadTs != null) {
      result
        ..add('thread_ts')
        ..add(serializers.serialize(object.threadTs,
            specifiedType: const FullType(String)));
    }
    if (object.replyCount != null) {
      result
        ..add('reply_count')
        ..add(serializers.serialize(object.replyCount,
            specifiedType: const FullType(int)));
    }
    if (object.replies != null) {
      result
        ..add('replies')
        ..add(serializers.serialize(object.replies,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Reply)])));
    }
    if (object.subscribed != null) {
      result
        ..add('subscribed')
        ..add(serializers.serialize(object.subscribed,
            specifiedType: const FullType(bool)));
    }
    if (object.lastRead != null) {
      result
        ..add('last_read')
        ..add(serializers.serialize(object.lastRead,
            specifiedType: const FullType(String)));
    }
    if (object.unreadCount != null) {
      result
        ..add('unread_count')
        ..add(serializers.serialize(object.unreadCount,
            specifiedType: const FullType(int)));
    }
    if (object.ts != null) {
      result
        ..add('ts')
        ..add(serializers.serialize(object.ts,
            specifiedType: const FullType(String)));
    }
    if (object.files != null) {
      result
        ..add('files')
        ..add(serializers.serialize(object.files,
            specifiedType:
                const FullType(BuiltList, const [const FullType(File)])));
    }

    return result;
  }

  @override
  Message deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MessageBuilder();

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
        case 'files':
          result.files.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(File)]))
              as BuiltList);
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
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
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

class _$FileSerializer implements StructuredSerializer<File> {
  @override
  final Iterable<Type> types = const [File, _$File];
  @override
  final String wireName = 'File';

  @override
  Iterable serialize(Serializers serializers, File object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'created',
      serializers.serialize(object.created, specifiedType: const FullType(int)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'mimetype',
      serializers.serialize(object.mimetype,
          specifiedType: const FullType(String)),
      'filetype',
      serializers.serialize(object.filetype,
          specifiedType: const FullType(String)),
      'pretty_type',
      serializers.serialize(object.prettyType,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'editable',
      serializers.serialize(object.editable,
          specifiedType: const FullType(bool)),
      'size',
      serializers.serialize(object.size, specifiedType: const FullType(int)),
      'mode',
      serializers.serialize(object.mode, specifiedType: const FullType(String)),
      'is_external',
      serializers.serialize(object.isExternal,
          specifiedType: const FullType(bool)),
      'external_type',
      serializers.serialize(object.externalType,
          specifiedType: const FullType(String)),
      'is_public',
      serializers.serialize(object.isPublic,
          specifiedType: const FullType(bool)),
      'public_url_shared',
      serializers.serialize(object.publicUrlShared,
          specifiedType: const FullType(bool)),
      'display_as_bot',
      serializers.serialize(object.displayAsBot,
          specifiedType: const FullType(bool)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'url_private',
      serializers.serialize(object.urlPrivate,
          specifiedType: const FullType(String)),
      'url_private_download',
      serializers.serialize(object.urlPrivateDownload,
          specifiedType: const FullType(String)),
      'thumb_64',
      serializers.serialize(object.thumb64,
          specifiedType: const FullType(String)),
      'thumb_80',
      serializers.serialize(object.thumb80,
          specifiedType: const FullType(String)),
      'thumb_360',
      serializers.serialize(object.thumb360,
          specifiedType: const FullType(String)),
      'thumb_360_w',
      serializers.serialize(object.thumb360W,
          specifiedType: const FullType(int)),
      'thumb_360_h',
      serializers.serialize(object.thumb360H,
          specifiedType: const FullType(int)),
      'thumb_480',
      serializers.serialize(object.thumb480,
          specifiedType: const FullType(String)),
      'thumb_480_w',
      serializers.serialize(object.thumb480W,
          specifiedType: const FullType(int)),
      'thumb_480_h',
      serializers.serialize(object.thumb480H,
          specifiedType: const FullType(int)),
      'thumb_160',
      serializers.serialize(object.thumb160,
          specifiedType: const FullType(String)),
      'thumb_720',
      serializers.serialize(object.thumb720,
          specifiedType: const FullType(String)),
      'thumb_720_w',
      serializers.serialize(object.thumb720W,
          specifiedType: const FullType(int)),
      'thumb_720_h',
      serializers.serialize(object.thumb720H,
          specifiedType: const FullType(int)),
      'thumb_800',
      serializers.serialize(object.thumb800,
          specifiedType: const FullType(String)),
      'thumb_800_w',
      serializers.serialize(object.thumb800W,
          specifiedType: const FullType(int)),
      'thumb_800_h',
      serializers.serialize(object.thumb800H,
          specifiedType: const FullType(int)),
      'image_exif_rotation',
      serializers.serialize(object.imageExifRotation,
          specifiedType: const FullType(int)),
      'original_w',
      serializers.serialize(object.originalW,
          specifiedType: const FullType(int)),
      'original_h',
      serializers.serialize(object.originalH,
          specifiedType: const FullType(int)),
      'permalink',
      serializers.serialize(object.permalink,
          specifiedType: const FullType(String)),
      'permalink_public',
      serializers.serialize(object.permalinkPublic,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  File deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FileBuilder();

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
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mimetype':
          result.mimetype = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filetype':
          result.filetype = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pretty_type':
          result.prettyType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'editable':
          result.editable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'size':
          result.size = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'mode':
          result.mode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_external':
          result.isExternal = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'external_type':
          result.externalType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_public':
          result.isPublic = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'public_url_shared':
          result.publicUrlShared = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'display_as_bot':
          result.displayAsBot = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url_private':
          result.urlPrivate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url_private_download':
          result.urlPrivateDownload = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_64':
          result.thumb64 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_80':
          result.thumb80 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_360':
          result.thumb360 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_360_w':
          result.thumb360W = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumb_360_h':
          result.thumb360H = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumb_480':
          result.thumb480 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_480_w':
          result.thumb480W = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumb_480_h':
          result.thumb480H = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumb_160':
          result.thumb160 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_720':
          result.thumb720 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_720_w':
          result.thumb720W = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumb_720_h':
          result.thumb720H = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumb_800':
          result.thumb800 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb_800_w':
          result.thumb800W = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumb_800_h':
          result.thumb800H = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'image_exif_rotation':
          result.imageExifRotation = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'original_w':
          result.originalW = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'original_h':
          result.originalH = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'permalink':
          result.permalink = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'permalink_public':
          result.permalinkPublic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Message extends Message {
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
  @override
  final BuiltList<File> files;

  factory _$Message([void updates(MessageBuilder b)]) =>
      (new MessageBuilder()..update(updates)).build();

  _$Message._(
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
      this.ts,
      this.files})
      : super._();

  @override
  Message rebuild(void updates(MessageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => new MessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
        type == other.type &&
        user == other.user &&
        text == other.text &&
        clientMsgId == other.clientMsgId &&
        threadTs == other.threadTs &&
        replyCount == other.replyCount &&
        replies == other.replies &&
        subscribed == other.subscribed &&
        lastRead == other.lastRead &&
        unreadCount == other.unreadCount &&
        ts == other.ts &&
        files == other.files;
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
            ts.hashCode),
        files.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Message')
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
          ..add('ts', ts)
          ..add('files', files))
        .toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message _$v;

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

  ListBuilder<File> _files;
  ListBuilder<File> get files => _$this._files ??= new ListBuilder<File>();
  set files(ListBuilder<File> files) => _$this._files = files;

  MessageBuilder();

  MessageBuilder get _$this {
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
      _files = _$v.files?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Message other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
          new _$Message._(
              type: type,
              user: user,
              text: text,
              clientMsgId: clientMsgId,
              threadTs: threadTs,
              replyCount: replyCount,
              replies: _replies?.build(),
              subscribed: subscribed,
              lastRead: lastRead,
              unreadCount: unreadCount,
              ts: ts,
              files: _files?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'replies';
        _replies?.build();

        _$failedField = 'files';
        _files?.build();
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

class _$Reply extends Reply {
  @override
  final String user;
  @override
  final String ts;

  factory _$Reply([void updates(ReplyBuilder b)]) =>
      (new ReplyBuilder()..update(updates)).build();

  _$Reply._({this.user, this.ts}) : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('Reply', 'user');
    }
    if (ts == null) {
      throw new BuiltValueNullFieldError('Reply', 'ts');
    }
  }

  @override
  Reply rebuild(void updates(ReplyBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplyBuilder toBuilder() => new ReplyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reply && user == other.user && ts == other.ts;
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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

class _$File extends File {
  @override
  final String id;
  @override
  final int created;
  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String title;
  @override
  final String mimetype;
  @override
  final String filetype;
  @override
  final String prettyType;
  @override
  final String user;
  @override
  final bool editable;
  @override
  final int size;
  @override
  final String mode;
  @override
  final bool isExternal;
  @override
  final String externalType;
  @override
  final bool isPublic;
  @override
  final bool publicUrlShared;
  @override
  final bool displayAsBot;
  @override
  final String username;
  @override
  final String urlPrivate;
  @override
  final String urlPrivateDownload;
  @override
  final String thumb64;
  @override
  final String thumb80;
  @override
  final String thumb360;
  @override
  final int thumb360W;
  @override
  final int thumb360H;
  @override
  final String thumb480;
  @override
  final int thumb480W;
  @override
  final int thumb480H;
  @override
  final String thumb160;
  @override
  final String thumb720;
  @override
  final int thumb720W;
  @override
  final int thumb720H;
  @override
  final String thumb800;
  @override
  final int thumb800W;
  @override
  final int thumb800H;
  @override
  final int imageExifRotation;
  @override
  final int originalW;
  @override
  final int originalH;
  @override
  final String permalink;
  @override
  final String permalinkPublic;

  factory _$File([void updates(FileBuilder b)]) =>
      (new FileBuilder()..update(updates)).build();

  _$File._(
      {this.id,
      this.created,
      this.timestamp,
      this.name,
      this.title,
      this.mimetype,
      this.filetype,
      this.prettyType,
      this.user,
      this.editable,
      this.size,
      this.mode,
      this.isExternal,
      this.externalType,
      this.isPublic,
      this.publicUrlShared,
      this.displayAsBot,
      this.username,
      this.urlPrivate,
      this.urlPrivateDownload,
      this.thumb64,
      this.thumb80,
      this.thumb360,
      this.thumb360W,
      this.thumb360H,
      this.thumb480,
      this.thumb480W,
      this.thumb480H,
      this.thumb160,
      this.thumb720,
      this.thumb720W,
      this.thumb720H,
      this.thumb800,
      this.thumb800W,
      this.thumb800H,
      this.imageExifRotation,
      this.originalW,
      this.originalH,
      this.permalink,
      this.permalinkPublic})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('File', 'id');
    }
    if (created == null) {
      throw new BuiltValueNullFieldError('File', 'created');
    }
    if (timestamp == null) {
      throw new BuiltValueNullFieldError('File', 'timestamp');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('File', 'name');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('File', 'title');
    }
    if (mimetype == null) {
      throw new BuiltValueNullFieldError('File', 'mimetype');
    }
    if (filetype == null) {
      throw new BuiltValueNullFieldError('File', 'filetype');
    }
    if (prettyType == null) {
      throw new BuiltValueNullFieldError('File', 'prettyType');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('File', 'user');
    }
    if (editable == null) {
      throw new BuiltValueNullFieldError('File', 'editable');
    }
    if (size == null) {
      throw new BuiltValueNullFieldError('File', 'size');
    }
    if (mode == null) {
      throw new BuiltValueNullFieldError('File', 'mode');
    }
    if (isExternal == null) {
      throw new BuiltValueNullFieldError('File', 'isExternal');
    }
    if (externalType == null) {
      throw new BuiltValueNullFieldError('File', 'externalType');
    }
    if (isPublic == null) {
      throw new BuiltValueNullFieldError('File', 'isPublic');
    }
    if (publicUrlShared == null) {
      throw new BuiltValueNullFieldError('File', 'publicUrlShared');
    }
    if (displayAsBot == null) {
      throw new BuiltValueNullFieldError('File', 'displayAsBot');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('File', 'username');
    }
    if (urlPrivate == null) {
      throw new BuiltValueNullFieldError('File', 'urlPrivate');
    }
    if (urlPrivateDownload == null) {
      throw new BuiltValueNullFieldError('File', 'urlPrivateDownload');
    }
    if (thumb64 == null) {
      throw new BuiltValueNullFieldError('File', 'thumb64');
    }
    if (thumb80 == null) {
      throw new BuiltValueNullFieldError('File', 'thumb80');
    }
    if (thumb360 == null) {
      throw new BuiltValueNullFieldError('File', 'thumb360');
    }
    if (thumb360W == null) {
      throw new BuiltValueNullFieldError('File', 'thumb360W');
    }
    if (thumb360H == null) {
      throw new BuiltValueNullFieldError('File', 'thumb360H');
    }
    if (thumb480 == null) {
      throw new BuiltValueNullFieldError('File', 'thumb480');
    }
    if (thumb480W == null) {
      throw new BuiltValueNullFieldError('File', 'thumb480W');
    }
    if (thumb480H == null) {
      throw new BuiltValueNullFieldError('File', 'thumb480H');
    }
    if (thumb160 == null) {
      throw new BuiltValueNullFieldError('File', 'thumb160');
    }
    if (thumb720 == null) {
      throw new BuiltValueNullFieldError('File', 'thumb720');
    }
    if (thumb720W == null) {
      throw new BuiltValueNullFieldError('File', 'thumb720W');
    }
    if (thumb720H == null) {
      throw new BuiltValueNullFieldError('File', 'thumb720H');
    }
    if (thumb800 == null) {
      throw new BuiltValueNullFieldError('File', 'thumb800');
    }
    if (thumb800W == null) {
      throw new BuiltValueNullFieldError('File', 'thumb800W');
    }
    if (thumb800H == null) {
      throw new BuiltValueNullFieldError('File', 'thumb800H');
    }
    if (imageExifRotation == null) {
      throw new BuiltValueNullFieldError('File', 'imageExifRotation');
    }
    if (originalW == null) {
      throw new BuiltValueNullFieldError('File', 'originalW');
    }
    if (originalH == null) {
      throw new BuiltValueNullFieldError('File', 'originalH');
    }
    if (permalink == null) {
      throw new BuiltValueNullFieldError('File', 'permalink');
    }
    if (permalinkPublic == null) {
      throw new BuiltValueNullFieldError('File', 'permalinkPublic');
    }
  }

  @override
  File rebuild(void updates(FileBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FileBuilder toBuilder() => new FileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is File &&
        id == other.id &&
        created == other.created &&
        timestamp == other.timestamp &&
        name == other.name &&
        title == other.title &&
        mimetype == other.mimetype &&
        filetype == other.filetype &&
        prettyType == other.prettyType &&
        user == other.user &&
        editable == other.editable &&
        size == other.size &&
        mode == other.mode &&
        isExternal == other.isExternal &&
        externalType == other.externalType &&
        isPublic == other.isPublic &&
        publicUrlShared == other.publicUrlShared &&
        displayAsBot == other.displayAsBot &&
        username == other.username &&
        urlPrivate == other.urlPrivate &&
        urlPrivateDownload == other.urlPrivateDownload &&
        thumb64 == other.thumb64 &&
        thumb80 == other.thumb80 &&
        thumb360 == other.thumb360 &&
        thumb360W == other.thumb360W &&
        thumb360H == other.thumb360H &&
        thumb480 == other.thumb480 &&
        thumb480W == other.thumb480W &&
        thumb480H == other.thumb480H &&
        thumb160 == other.thumb160 &&
        thumb720 == other.thumb720 &&
        thumb720W == other.thumb720W &&
        thumb720H == other.thumb720H &&
        thumb800 == other.thumb800 &&
        thumb800W == other.thumb800W &&
        thumb800H == other.thumb800H &&
        imageExifRotation == other.imageExifRotation &&
        originalW == other.originalW &&
        originalH == other.originalH &&
        permalink == other.permalink &&
        permalinkPublic == other.permalinkPublic;
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
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), created.hashCode), timestamp.hashCode), name.hashCode), title.hashCode), mimetype.hashCode), filetype.hashCode), prettyType.hashCode), user.hashCode), editable.hashCode), size.hashCode), mode.hashCode), isExternal.hashCode), externalType.hashCode), isPublic.hashCode), publicUrlShared.hashCode), displayAsBot.hashCode), username.hashCode), urlPrivate.hashCode), urlPrivateDownload.hashCode), thumb64.hashCode),
                                                                                thumb80.hashCode),
                                                                            thumb360.hashCode),
                                                                        thumb360W.hashCode),
                                                                    thumb360H.hashCode),
                                                                thumb480.hashCode),
                                                            thumb480W.hashCode),
                                                        thumb480H.hashCode),
                                                    thumb160.hashCode),
                                                thumb720.hashCode),
                                            thumb720W.hashCode),
                                        thumb720H.hashCode),
                                    thumb800.hashCode),
                                thumb800W.hashCode),
                            thumb800H.hashCode),
                        imageExifRotation.hashCode),
                    originalW.hashCode),
                originalH.hashCode),
            permalink.hashCode),
        permalinkPublic.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('File')
          ..add('id', id)
          ..add('created', created)
          ..add('timestamp', timestamp)
          ..add('name', name)
          ..add('title', title)
          ..add('mimetype', mimetype)
          ..add('filetype', filetype)
          ..add('prettyType', prettyType)
          ..add('user', user)
          ..add('editable', editable)
          ..add('size', size)
          ..add('mode', mode)
          ..add('isExternal', isExternal)
          ..add('externalType', externalType)
          ..add('isPublic', isPublic)
          ..add('publicUrlShared', publicUrlShared)
          ..add('displayAsBot', displayAsBot)
          ..add('username', username)
          ..add('urlPrivate', urlPrivate)
          ..add('urlPrivateDownload', urlPrivateDownload)
          ..add('thumb64', thumb64)
          ..add('thumb80', thumb80)
          ..add('thumb360', thumb360)
          ..add('thumb360W', thumb360W)
          ..add('thumb360H', thumb360H)
          ..add('thumb480', thumb480)
          ..add('thumb480W', thumb480W)
          ..add('thumb480H', thumb480H)
          ..add('thumb160', thumb160)
          ..add('thumb720', thumb720)
          ..add('thumb720W', thumb720W)
          ..add('thumb720H', thumb720H)
          ..add('thumb800', thumb800)
          ..add('thumb800W', thumb800W)
          ..add('thumb800H', thumb800H)
          ..add('imageExifRotation', imageExifRotation)
          ..add('originalW', originalW)
          ..add('originalH', originalH)
          ..add('permalink', permalink)
          ..add('permalinkPublic', permalinkPublic))
        .toString();
  }
}

class FileBuilder implements Builder<File, FileBuilder> {
  _$File _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _created;
  int get created => _$this._created;
  set created(int created) => _$this._created = created;

  int _timestamp;
  int get timestamp => _$this._timestamp;
  set timestamp(int timestamp) => _$this._timestamp = timestamp;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _mimetype;
  String get mimetype => _$this._mimetype;
  set mimetype(String mimetype) => _$this._mimetype = mimetype;

  String _filetype;
  String get filetype => _$this._filetype;
  set filetype(String filetype) => _$this._filetype = filetype;

  String _prettyType;
  String get prettyType => _$this._prettyType;
  set prettyType(String prettyType) => _$this._prettyType = prettyType;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  bool _editable;
  bool get editable => _$this._editable;
  set editable(bool editable) => _$this._editable = editable;

  int _size;
  int get size => _$this._size;
  set size(int size) => _$this._size = size;

  String _mode;
  String get mode => _$this._mode;
  set mode(String mode) => _$this._mode = mode;

  bool _isExternal;
  bool get isExternal => _$this._isExternal;
  set isExternal(bool isExternal) => _$this._isExternal = isExternal;

  String _externalType;
  String get externalType => _$this._externalType;
  set externalType(String externalType) => _$this._externalType = externalType;

  bool _isPublic;
  bool get isPublic => _$this._isPublic;
  set isPublic(bool isPublic) => _$this._isPublic = isPublic;

  bool _publicUrlShared;
  bool get publicUrlShared => _$this._publicUrlShared;
  set publicUrlShared(bool publicUrlShared) =>
      _$this._publicUrlShared = publicUrlShared;

  bool _displayAsBot;
  bool get displayAsBot => _$this._displayAsBot;
  set displayAsBot(bool displayAsBot) => _$this._displayAsBot = displayAsBot;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _urlPrivate;
  String get urlPrivate => _$this._urlPrivate;
  set urlPrivate(String urlPrivate) => _$this._urlPrivate = urlPrivate;

  String _urlPrivateDownload;
  String get urlPrivateDownload => _$this._urlPrivateDownload;
  set urlPrivateDownload(String urlPrivateDownload) =>
      _$this._urlPrivateDownload = urlPrivateDownload;

  String _thumb64;
  String get thumb64 => _$this._thumb64;
  set thumb64(String thumb64) => _$this._thumb64 = thumb64;

  String _thumb80;
  String get thumb80 => _$this._thumb80;
  set thumb80(String thumb80) => _$this._thumb80 = thumb80;

  String _thumb360;
  String get thumb360 => _$this._thumb360;
  set thumb360(String thumb360) => _$this._thumb360 = thumb360;

  int _thumb360W;
  int get thumb360W => _$this._thumb360W;
  set thumb360W(int thumb360W) => _$this._thumb360W = thumb360W;

  int _thumb360H;
  int get thumb360H => _$this._thumb360H;
  set thumb360H(int thumb360H) => _$this._thumb360H = thumb360H;

  String _thumb480;
  String get thumb480 => _$this._thumb480;
  set thumb480(String thumb480) => _$this._thumb480 = thumb480;

  int _thumb480W;
  int get thumb480W => _$this._thumb480W;
  set thumb480W(int thumb480W) => _$this._thumb480W = thumb480W;

  int _thumb480H;
  int get thumb480H => _$this._thumb480H;
  set thumb480H(int thumb480H) => _$this._thumb480H = thumb480H;

  String _thumb160;
  String get thumb160 => _$this._thumb160;
  set thumb160(String thumb160) => _$this._thumb160 = thumb160;

  String _thumb720;
  String get thumb720 => _$this._thumb720;
  set thumb720(String thumb720) => _$this._thumb720 = thumb720;

  int _thumb720W;
  int get thumb720W => _$this._thumb720W;
  set thumb720W(int thumb720W) => _$this._thumb720W = thumb720W;

  int _thumb720H;
  int get thumb720H => _$this._thumb720H;
  set thumb720H(int thumb720H) => _$this._thumb720H = thumb720H;

  String _thumb800;
  String get thumb800 => _$this._thumb800;
  set thumb800(String thumb800) => _$this._thumb800 = thumb800;

  int _thumb800W;
  int get thumb800W => _$this._thumb800W;
  set thumb800W(int thumb800W) => _$this._thumb800W = thumb800W;

  int _thumb800H;
  int get thumb800H => _$this._thumb800H;
  set thumb800H(int thumb800H) => _$this._thumb800H = thumb800H;

  int _imageExifRotation;
  int get imageExifRotation => _$this._imageExifRotation;
  set imageExifRotation(int imageExifRotation) =>
      _$this._imageExifRotation = imageExifRotation;

  int _originalW;
  int get originalW => _$this._originalW;
  set originalW(int originalW) => _$this._originalW = originalW;

  int _originalH;
  int get originalH => _$this._originalH;
  set originalH(int originalH) => _$this._originalH = originalH;

  String _permalink;
  String get permalink => _$this._permalink;
  set permalink(String permalink) => _$this._permalink = permalink;

  String _permalinkPublic;
  String get permalinkPublic => _$this._permalinkPublic;
  set permalinkPublic(String permalinkPublic) =>
      _$this._permalinkPublic = permalinkPublic;

  FileBuilder();

  FileBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _created = _$v.created;
      _timestamp = _$v.timestamp;
      _name = _$v.name;
      _title = _$v.title;
      _mimetype = _$v.mimetype;
      _filetype = _$v.filetype;
      _prettyType = _$v.prettyType;
      _user = _$v.user;
      _editable = _$v.editable;
      _size = _$v.size;
      _mode = _$v.mode;
      _isExternal = _$v.isExternal;
      _externalType = _$v.externalType;
      _isPublic = _$v.isPublic;
      _publicUrlShared = _$v.publicUrlShared;
      _displayAsBot = _$v.displayAsBot;
      _username = _$v.username;
      _urlPrivate = _$v.urlPrivate;
      _urlPrivateDownload = _$v.urlPrivateDownload;
      _thumb64 = _$v.thumb64;
      _thumb80 = _$v.thumb80;
      _thumb360 = _$v.thumb360;
      _thumb360W = _$v.thumb360W;
      _thumb360H = _$v.thumb360H;
      _thumb480 = _$v.thumb480;
      _thumb480W = _$v.thumb480W;
      _thumb480H = _$v.thumb480H;
      _thumb160 = _$v.thumb160;
      _thumb720 = _$v.thumb720;
      _thumb720W = _$v.thumb720W;
      _thumb720H = _$v.thumb720H;
      _thumb800 = _$v.thumb800;
      _thumb800W = _$v.thumb800W;
      _thumb800H = _$v.thumb800H;
      _imageExifRotation = _$v.imageExifRotation;
      _originalW = _$v.originalW;
      _originalH = _$v.originalH;
      _permalink = _$v.permalink;
      _permalinkPublic = _$v.permalinkPublic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(File other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$File;
  }

  @override
  void update(void updates(FileBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$File build() {
    final _$result = _$v ??
        new _$File._(
            id: id,
            created: created,
            timestamp: timestamp,
            name: name,
            title: title,
            mimetype: mimetype,
            filetype: filetype,
            prettyType: prettyType,
            user: user,
            editable: editable,
            size: size,
            mode: mode,
            isExternal: isExternal,
            externalType: externalType,
            isPublic: isPublic,
            publicUrlShared: publicUrlShared,
            displayAsBot: displayAsBot,
            username: username,
            urlPrivate: urlPrivate,
            urlPrivateDownload: urlPrivateDownload,
            thumb64: thumb64,
            thumb80: thumb80,
            thumb360: thumb360,
            thumb360W: thumb360W,
            thumb360H: thumb360H,
            thumb480: thumb480,
            thumb480W: thumb480W,
            thumb480H: thumb480H,
            thumb160: thumb160,
            thumb720: thumb720,
            thumb720W: thumb720W,
            thumb720H: thumb720H,
            thumb800: thumb800,
            thumb800W: thumb800W,
            thumb800H: thumb800H,
            imageExifRotation: imageExifRotation,
            originalW: originalW,
            originalH: originalH,
            permalink: permalink,
            permalinkPublic: permalinkPublic);
    replace(_$result);
    return _$result;
  }
}
