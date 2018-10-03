// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

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

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(ConversationList.serializer)
      ..add(File.serializer)
      ..add(Members.serializer)
      ..add(Message.serializer)
      ..add(PostMessageRequest.serializer)
      ..add(PostMessageResponse.serializer)
      ..add(Profile.serializer)
      ..add(Reply.serializer)
      ..add(SlackToken.serializer)
      ..add(Team.serializer)
      ..add(User.serializer)
      ..add(UserIdentity.serializer)
      ..add(UserList.serializer)
      ..add(UserProfileResponse.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Members)]),
          () => new ListBuilder<Members>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Message)]),
          () => new ListBuilder<Message>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Reply)]),
          () => new ListBuilder<Reply>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(File)]),
          () => new ListBuilder<File>()))
    .build();
