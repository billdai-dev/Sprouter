// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_list.dart';

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

Serializer<ConversationList> _$conversationListSerializer =
    new _$ConversationListSerializer();

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
    if (object.messages != null) {
      result
        ..add('messages')
        ..add(serializers.serialize(object.messages,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Message)])));
    }
    if (object.hasMore != null) {
      result
        ..add('has_more')
        ..add(serializers.serialize(object.hasMore,
            specifiedType: const FullType(bool)));
    }
    if (object.ok != null) {
      result
        ..add('ok')
        ..add(serializers.serialize(object.ok,
            specifiedType: const FullType(bool)));
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
        case 'messages':
          result.messages.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Message)])) as BuiltList);
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

class _$ConversationList extends ConversationList {
  @override
  final BuiltList<Message> messages;
  @override
  final bool hasMore;
  @override
  final bool ok;

  factory _$ConversationList([void updates(ConversationListBuilder b)]) =>
      (new ConversationListBuilder()..update(updates)).build();

  _$ConversationList._({this.messages, this.hasMore, this.ok}) : super._();

  @override
  ConversationList rebuild(void updates(ConversationListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ConversationListBuilder toBuilder() =>
      new ConversationListBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ConversationList) return false;
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
    return (newBuiltValueToStringHelper('ConversationList')
          ..add('messages', messages)
          ..add('hasMore', hasMore)
          ..add('ok', ok))
        .toString();
  }
}

class ConversationListBuilder
    implements Builder<ConversationList, ConversationListBuilder> {
  _$ConversationList _$v;

  ListBuilder<Message> _messages;
  ListBuilder<Message> get messages =>
      _$this._messages ??= new ListBuilder<Message>();
  set messages(ListBuilder<Message> messages) => _$this._messages = messages;

  bool _hasMore;
  bool get hasMore => _$this._hasMore;
  set hasMore(bool hasMore) => _$this._hasMore = hasMore;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  ConversationListBuilder();

  ConversationListBuilder get _$this {
    if (_$v != null) {
      _messages = _$v.messages?.toBuilder();
      _hasMore = _$v.hasMore;
      _ok = _$v.ok;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConversationList other) {
    if (other == null) throw new ArgumentError.notNull('other');
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
              messages: _messages?.build(), hasMore: hasMore, ok: ok);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'messages';
        _messages?.build();
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
