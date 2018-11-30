import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';
import 'package:sprouter/data/model/slack/profile.dart';

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

  @nullable
  @BuiltValueField(compare: false, serialize: false)
  Profile get userProfile;

  @nullable
  @BuiltValueField(compare: false, serialize: false)
  bool get isAddedBySprouter;

  @nullable
  @BuiltValueField(compare: false, serialize: false)
  bool get isFavoriteDrink;

  String toJson() {
    return json.encode(serializers.serializeWith(Message.serializer, this));
  }

  String get getShopName =>
      files?.elementAt(0)?.title?.split(" ")?.elementAt(1);

  static Message fromJson(String jsonString) {
    return serializers.deserializeWith(
        Message.serializer, json.decode(jsonString));
  }

  static Serializer<Message> get serializer => _$messageSerializer;
}

abstract class Reply implements Built<Reply, ReplyBuilder> {
  Reply._();

  factory Reply([updates(ReplyBuilder b)]) = _$Reply;

  @nullable
  @BuiltValueField(wireName: 'user')
  String get user;

  @nullable
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

  @nullable
  @BuiltValueField(wireName: 'id')
  String get id;

  @nullable
  @BuiltValueField(wireName: 'created')
  int get created;

  @nullable
  @BuiltValueField(wireName: 'timestamp')
  int get timestamp;

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'title')
  String get title;

  @nullable
  @BuiltValueField(wireName: 'mimetype')
  String get mimetype;

  @nullable
  @BuiltValueField(wireName: 'filetype')
  String get filetype;

  @nullable
  @BuiltValueField(wireName: 'pretty_type')
  String get prettyType;

  @nullable
  @BuiltValueField(wireName: 'user')
  String get user;

  @nullable
  @BuiltValueField(wireName: 'editable')
  bool get editable;

  @nullable
  @BuiltValueField(wireName: 'size')
  int get size;

  @nullable
  @BuiltValueField(wireName: 'mode')
  String get mode;

  @nullable
  @BuiltValueField(wireName: 'is_external')
  bool get isExternal;

  @nullable
  @BuiltValueField(wireName: 'external_type')
  String get externalType;

  @nullable
  @BuiltValueField(wireName: 'is_public')
  bool get isPublic;

  @nullable
  @BuiltValueField(wireName: 'public_url_shared')
  bool get publicUrlShared;

  @nullable
  @BuiltValueField(wireName: 'display_as_bot')
  bool get displayAsBot;

  @nullable
  @BuiltValueField(wireName: 'username')
  String get username;

  @nullable
  @BuiltValueField(wireName: 'url_private')
  String get urlPrivate;

  @nullable
  @BuiltValueField(wireName: 'url_private_download')
  String get urlPrivateDownload;

  @nullable
  @BuiltValueField(wireName: 'thumb_64')
  String get thumb64;

  @nullable
  @BuiltValueField(wireName: 'thumb_80')
  String get thumb80;

  @nullable
  @BuiltValueField(wireName: 'thumb_360')
  String get thumb360;

  @nullable
  @BuiltValueField(wireName: 'thumb_360_w')
  int get thumb360W;

  @nullable
  @BuiltValueField(wireName: 'thumb_360_h')
  int get thumb360H;

  @nullable
  @BuiltValueField(wireName: 'thumb_480')
  String get thumb480;

  @nullable
  @BuiltValueField(wireName: 'thumb_480_w')
  int get thumb480W;

  @nullable
  @BuiltValueField(wireName: 'thumb_480_h')
  int get thumb480H;

  @nullable
  @BuiltValueField(wireName: 'thumb_160')
  String get thumb160;

  @nullable
  @BuiltValueField(wireName: 'thumb_720')
  String get thumb720;

  @nullable
  @BuiltValueField(wireName: 'thumb_720_w')
  int get thumb720W;

  @nullable
  @BuiltValueField(wireName: 'thumb_720_h')
  int get thumb720H;

  @nullable
  @BuiltValueField(wireName: 'thumb_800')
  String get thumb800;

  @nullable
  @BuiltValueField(wireName: 'thumb_800_w')
  int get thumb800W;

  @nullable
  @BuiltValueField(wireName: 'thumb_800_h')
  int get thumb800H;

  @nullable
  @BuiltValueField(wireName: 'image_exif_rotation')
  int get imageExifRotation;

  @nullable
  @BuiltValueField(wireName: 'original_w')
  int get originalW;

  @nullable
  @BuiltValueField(wireName: 'original_h')
  int get originalH;

  @nullable
  @BuiltValueField(wireName: 'permalink')
  String get permalink;

  @nullable
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
