import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sprouter/data/model/serializers.dart';

part 'slack_token.g.dart';

abstract class SlackToken implements Built<SlackToken, SlackTokenBuilder> {
  SlackToken._();

  factory SlackToken([updates(SlackTokenBuilder b)]) = _$SlackToken;

  @BuiltValueField(wireName: 'access_token')
  String get accessToken;

  @nullable
  @BuiltValueField(wireName: 'scope')
  String get scope;

  @nullable
  @BuiltValueField(wireName: 'team_name')
  String get teamName;

  @nullable
  @BuiltValueField(wireName: 'team_id')
  String get teamId;

  String toJson() {
    return json.encode(serializers.serializeWith(SlackToken.serializer, this));
  }

  static SlackToken fromJson(String jsonString) {
    return serializers.deserializeWith(
        SlackToken.serializer, json.decode(jsonString));
  }

  static Serializer<SlackToken> get serializer => _$slackTokenSerializer;
}
