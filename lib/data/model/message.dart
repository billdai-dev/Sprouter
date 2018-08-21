import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';

part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {
  Message._();

  factory Message([updates(MessageBuilder b)]) = _$Message;

  @nullable
  @BuiltValueField(wireName: 'type')
  String get type;

  @nullable
  @BuiltValueField(wireName: 'user')
  String get user;

  @nullable
  @BuiltValueField(wireName: 'text')
  String get text;

  @nullable
  @BuiltValueField(wireName: 'client_msg_id')
  String get clientMsgId;

  @nullable
  @BuiltValueField(wireName: 'thread_ts')
  String get threadTs;

  @nullable
  @BuiltValueField(wireName: 'reply_count')
  int get replyCount;

  @nullable
  @BuiltValueField(wireName: 'replies')
  BuiltList<Reply> get replies;

  @nullable
  @BuiltValueField(wireName: 'subscribed')
  bool get subscribed;

  @nullable
  @BuiltValueField(wireName: 'last_read')
  String get lastRead;

  @nullable
  @BuiltValueField(wireName: 'unread_count')
  int get unreadCount;

  @nullable
  @BuiltValueField(wireName: 'ts')
  String get ts;

  @nullable
  @BuiltValueField(wireName: 'files')
  BuiltList<File> get files;

  String toJson() {
    return json.encode(serializers.serializeWith(Message.serializer, this));
  }

  static Message fromJson(String jsonString) {
    return serializers.deserializeWith(
        Message.serializer, json.decode(jsonString));
  }

  static Serializer<Message> get serializer => _$messageSerializer;
}

abstract class Reply implements Built<Reply, ReplyBuilder> {
  Reply._();

  factory Reply([updates(ReplyBuilder b)]) = _$Reply;

  @BuiltValueField(wireName: 'user')
  String get user;

  @BuiltValueField(wireName: 'ts')
  String get ts;

  String toJson() {
    return json.encode(serializers.serializeWith(Reply.serializer, this));
  }

  static Reply fromJson(String jsonString) {
    return serializers.deserializeWith(
        Reply.serializer, json.decode(jsonString));
  }

  static Serializer<Reply> get serializer => _$replySerializer;
}

abstract class File implements Built<File, FileBuilder> {
  File._();

  factory File([updates(FileBuilder b)]) = _$File;

  @BuiltValueField(wireName: 'id')
  String get id;

  @BuiltValueField(wireName: 'created')
  int get created;

  @BuiltValueField(wireName: 'timestamp')
  int get timestamp;

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'title')
  String get title;

  @BuiltValueField(wireName: 'mimetype')
  String get mimetype;

  @BuiltValueField(wireName: 'filetype')
  String get filetype;

  @BuiltValueField(wireName: 'pretty_type')
  String get prettyType;

  @BuiltValueField(wireName: 'user')
  String get user;

  @BuiltValueField(wireName: 'editable')
  bool get editable;

  @BuiltValueField(wireName: 'size')
  int get size;

  @BuiltValueField(wireName: 'mode')
  String get mode;

  @BuiltValueField(wireName: 'is_external')
  bool get isExternal;

  @BuiltValueField(wireName: 'external_type')
  String get externalType;

  @BuiltValueField(wireName: 'is_public')
  bool get isPublic;

  @BuiltValueField(wireName: 'public_url_shared')
  bool get publicUrlShared;

  @BuiltValueField(wireName: 'display_as_bot')
  bool get displayAsBot;

  @BuiltValueField(wireName: 'username')
  String get username;

  @BuiltValueField(wireName: 'url_private')
  String get urlPrivate;

  @BuiltValueField(wireName: 'url_private_download')
  String get urlPrivateDownload;

  @BuiltValueField(wireName: 'thumb_64')
  String get thumb64;

  @BuiltValueField(wireName: 'thumb_80')
  String get thumb80;

  @BuiltValueField(wireName: 'thumb_360')
  String get thumb360;

  @BuiltValueField(wireName: 'thumb_360_w')
  int get thumb360W;

  @BuiltValueField(wireName: 'thumb_360_h')
  int get thumb360H;

  @BuiltValueField(wireName: 'thumb_480')
  String get thumb480;

  @BuiltValueField(wireName: 'thumb_480_w')
  int get thumb480W;

  @BuiltValueField(wireName: 'thumb_480_h')
  int get thumb480H;

  @BuiltValueField(wireName: 'thumb_160')
  String get thumb160;

  @BuiltValueField(wireName: 'thumb_720')
  String get thumb720;

  @BuiltValueField(wireName: 'thumb_720_w')
  int get thumb720W;

  @BuiltValueField(wireName: 'thumb_720_h')
  int get thumb720H;

  @BuiltValueField(wireName: 'thumb_800')
  String get thumb800;

  @BuiltValueField(wireName: 'thumb_800_w')
  int get thumb800W;

  @BuiltValueField(wireName: 'thumb_800_h')
  int get thumb800H;

  @BuiltValueField(wireName: 'image_exif_rotation')
  int get imageExifRotation;

  @BuiltValueField(wireName: 'original_w')
  int get originalW;

  @BuiltValueField(wireName: 'original_h')
  int get originalH;

  @BuiltValueField(wireName: 'permalink')
  String get permalink;

  @BuiltValueField(wireName: 'permalink_public')
  String get permalinkPublic;

  String toJson() {
    return json.encode(serializers.serializeWith(File.serializer, this));
  }

  static File fromJson(String jsonString) {
    return serializers.deserializeWith(
        File.serializer, json.decode(jsonString));
  }

  static Serializer<File> get serializer => _$fileSerializer;
}

