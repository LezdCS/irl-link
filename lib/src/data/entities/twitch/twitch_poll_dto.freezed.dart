// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_poll_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TwitchPollDTO {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<ChoiceDTO> get choices => throw _privateConstructorUsedError;
  int get totalVotes => throw _privateConstructorUsedError;
  PollStatus get status => throw _privateConstructorUsedError;
  DateTime get endsAt => throw _privateConstructorUsedError;

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TwitchPollDTOCopyWith<TwitchPollDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwitchPollDTOCopyWith<$Res> {
  factory $TwitchPollDTOCopyWith(
          TwitchPollDTO value, $Res Function(TwitchPollDTO) then) =
      _$TwitchPollDTOCopyWithImpl<$Res, TwitchPollDTO>;
  @useResult
  $Res call(
      {String id,
      String title,
      List<ChoiceDTO> choices,
      int totalVotes,
      PollStatus status,
      DateTime endsAt});
}

/// @nodoc
class _$TwitchPollDTOCopyWithImpl<$Res, $Val extends TwitchPollDTO>
    implements $TwitchPollDTOCopyWith<$Res> {
  _$TwitchPollDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? choices = null,
    Object? totalVotes = null,
    Object? status = null,
    Object? endsAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceDTO>,
      totalVotes: null == totalVotes
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollStatus,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TwitchPollDTOImplCopyWith<$Res>
    implements $TwitchPollDTOCopyWith<$Res> {
  factory _$$TwitchPollDTOImplCopyWith(
          _$TwitchPollDTOImpl value, $Res Function(_$TwitchPollDTOImpl) then) =
      __$$TwitchPollDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      List<ChoiceDTO> choices,
      int totalVotes,
      PollStatus status,
      DateTime endsAt});
}

/// @nodoc
class __$$TwitchPollDTOImplCopyWithImpl<$Res>
    extends _$TwitchPollDTOCopyWithImpl<$Res, _$TwitchPollDTOImpl>
    implements _$$TwitchPollDTOImplCopyWith<$Res> {
  __$$TwitchPollDTOImplCopyWithImpl(
      _$TwitchPollDTOImpl _value, $Res Function(_$TwitchPollDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? choices = null,
    Object? totalVotes = null,
    Object? status = null,
    Object? endsAt = null,
  }) {
    return _then(_$TwitchPollDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceDTO>,
      totalVotes: null == totalVotes
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollStatus,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TwitchPollDTOImpl implements _TwitchPollDTO {
  const _$TwitchPollDTOImpl(
      {required this.id,
      required this.title,
      required final List<ChoiceDTO> choices,
      required this.totalVotes,
      required this.status,
      required this.endsAt})
      : _choices = choices;

  @override
  final String id;
  @override
  final String title;
  final List<ChoiceDTO> _choices;
  @override
  List<ChoiceDTO> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  final int totalVotes;
  @override
  final PollStatus status;
  @override
  final DateTime endsAt;

  @override
  String toString() {
    return 'TwitchPollDTO(id: $id, title: $title, choices: $choices, totalVotes: $totalVotes, status: $status, endsAt: $endsAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwitchPollDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.totalVotes, totalVotes) ||
                other.totalVotes == totalVotes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_choices),
      totalVotes,
      status,
      endsAt);

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TwitchPollDTOImplCopyWith<_$TwitchPollDTOImpl> get copyWith =>
      __$$TwitchPollDTOImplCopyWithImpl<_$TwitchPollDTOImpl>(this, _$identity);
}

abstract class _TwitchPollDTO implements TwitchPollDTO {
  const factory _TwitchPollDTO(
      {required final String id,
      required final String title,
      required final List<ChoiceDTO> choices,
      required final int totalVotes,
      required final PollStatus status,
      required final DateTime endsAt}) = _$TwitchPollDTOImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  List<ChoiceDTO> get choices;
  @override
  int get totalVotes;
  @override
  PollStatus get status;
  @override
  DateTime get endsAt;

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TwitchPollDTOImplCopyWith<_$TwitchPollDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChoiceDTO _$ChoiceDTOFromJson(Map<String, dynamic> json) {
  return _ChoiceDTO.fromJson(json);
}

/// @nodoc
mixin _$ChoiceDTO {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get votes => throw _privateConstructorUsedError;

  /// Serializes this ChoiceDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChoiceDTOCopyWith<ChoiceDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChoiceDTOCopyWith<$Res> {
  factory $ChoiceDTOCopyWith(ChoiceDTO value, $Res Function(ChoiceDTO) then) =
      _$ChoiceDTOCopyWithImpl<$Res, ChoiceDTO>;
  @useResult
  $Res call({String id, String title, int votes});
}

/// @nodoc
class _$ChoiceDTOCopyWithImpl<$Res, $Val extends ChoiceDTO>
    implements $ChoiceDTOCopyWith<$Res> {
  _$ChoiceDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? votes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChoiceDTOImplCopyWith<$Res>
    implements $ChoiceDTOCopyWith<$Res> {
  factory _$$ChoiceDTOImplCopyWith(
          _$ChoiceDTOImpl value, $Res Function(_$ChoiceDTOImpl) then) =
      __$$ChoiceDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, int votes});
}

/// @nodoc
class __$$ChoiceDTOImplCopyWithImpl<$Res>
    extends _$ChoiceDTOCopyWithImpl<$Res, _$ChoiceDTOImpl>
    implements _$$ChoiceDTOImplCopyWith<$Res> {
  __$$ChoiceDTOImplCopyWithImpl(
      _$ChoiceDTOImpl _value, $Res Function(_$ChoiceDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? votes = null,
  }) {
    return _then(_$ChoiceDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChoiceDTOImpl implements _ChoiceDTO {
  const _$ChoiceDTOImpl(
      {required this.id, required this.title, this.votes = 0});

  factory _$ChoiceDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChoiceDTOImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final int votes;

  @override
  String toString() {
    return 'ChoiceDTO(id: $id, title: $title, votes: $votes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoiceDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.votes, votes) || other.votes == votes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, votes);

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoiceDTOImplCopyWith<_$ChoiceDTOImpl> get copyWith =>
      __$$ChoiceDTOImplCopyWithImpl<_$ChoiceDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChoiceDTOImplToJson(
      this,
    );
  }
}

abstract class _ChoiceDTO implements ChoiceDTO {
  const factory _ChoiceDTO(
      {required final String id,
      required final String title,
      final int votes}) = _$ChoiceDTOImpl;

  factory _ChoiceDTO.fromJson(Map<String, dynamic> json) =
      _$ChoiceDTOImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int get votes;

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChoiceDTOImplCopyWith<_$ChoiceDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
