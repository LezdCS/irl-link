// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_poll_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitchPollDTO {
  String get id;
  String get title;
  List<ChoiceDTO> get choices;
  int get totalVotes;
  PollStatus get status;
  DateTime get endsAt;

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TwitchPollDTOCopyWith<TwitchPollDTO> get copyWith =>
      _$TwitchPollDTOCopyWithImpl<TwitchPollDTO>(
          this as TwitchPollDTO, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TwitchPollDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.choices, choices) &&
            (identical(other.totalVotes, totalVotes) ||
                other.totalVotes == totalVotes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title,
      const DeepCollectionEquality().hash(choices), totalVotes, status, endsAt);

  @override
  String toString() {
    return 'TwitchPollDTO(id: $id, title: $title, choices: $choices, totalVotes: $totalVotes, status: $status, endsAt: $endsAt)';
  }
}

/// @nodoc
abstract mixin class $TwitchPollDTOCopyWith<$Res> {
  factory $TwitchPollDTOCopyWith(
          TwitchPollDTO value, $Res Function(TwitchPollDTO) _then) =
      _$TwitchPollDTOCopyWithImpl;
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
class _$TwitchPollDTOCopyWithImpl<$Res>
    implements $TwitchPollDTOCopyWith<$Res> {
  _$TwitchPollDTOCopyWithImpl(this._self, this._then);

  final TwitchPollDTO _self;
  final $Res Function(TwitchPollDTO) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _self.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceDTO>,
      totalVotes: null == totalVotes
          ? _self.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollStatus,
      endsAt: null == endsAt
          ? _self.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _TwitchPollDTO implements TwitchPollDTO {
  const _TwitchPollDTO(
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

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TwitchPollDTOCopyWith<_TwitchPollDTO> get copyWith =>
      __$TwitchPollDTOCopyWithImpl<_TwitchPollDTO>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TwitchPollDTO &&
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

  @override
  String toString() {
    return 'TwitchPollDTO(id: $id, title: $title, choices: $choices, totalVotes: $totalVotes, status: $status, endsAt: $endsAt)';
  }
}

/// @nodoc
abstract mixin class _$TwitchPollDTOCopyWith<$Res>
    implements $TwitchPollDTOCopyWith<$Res> {
  factory _$TwitchPollDTOCopyWith(
          _TwitchPollDTO value, $Res Function(_TwitchPollDTO) _then) =
      __$TwitchPollDTOCopyWithImpl;
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
class __$TwitchPollDTOCopyWithImpl<$Res>
    implements _$TwitchPollDTOCopyWith<$Res> {
  __$TwitchPollDTOCopyWithImpl(this._self, this._then);

  final _TwitchPollDTO _self;
  final $Res Function(_TwitchPollDTO) _then;

  /// Create a copy of TwitchPollDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? choices = null,
    Object? totalVotes = null,
    Object? status = null,
    Object? endsAt = null,
  }) {
    return _then(_TwitchPollDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      choices: null == choices
          ? _self._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<ChoiceDTO>,
      totalVotes: null == totalVotes
          ? _self.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollStatus,
      endsAt: null == endsAt
          ? _self.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$ChoiceDTO {
  String get id;
  String get title;
  int get votes;

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChoiceDTOCopyWith<ChoiceDTO> get copyWith =>
      _$ChoiceDTOCopyWithImpl<ChoiceDTO>(this as ChoiceDTO, _$identity);

  /// Serializes this ChoiceDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChoiceDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.votes, votes) || other.votes == votes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, votes);

  @override
  String toString() {
    return 'ChoiceDTO(id: $id, title: $title, votes: $votes)';
  }
}

/// @nodoc
abstract mixin class $ChoiceDTOCopyWith<$Res> {
  factory $ChoiceDTOCopyWith(ChoiceDTO value, $Res Function(ChoiceDTO) _then) =
      _$ChoiceDTOCopyWithImpl;
  @useResult
  $Res call({String id, String title, int votes});
}

/// @nodoc
class _$ChoiceDTOCopyWithImpl<$Res> implements $ChoiceDTOCopyWith<$Res> {
  _$ChoiceDTOCopyWithImpl(this._self, this._then);

  final ChoiceDTO _self;
  final $Res Function(ChoiceDTO) _then;

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? votes = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      votes: null == votes
          ? _self.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChoiceDTO implements ChoiceDTO {
  const _ChoiceDTO({required this.id, required this.title, this.votes = 0});
  factory _ChoiceDTO.fromJson(Map<String, dynamic> json) =>
      _$ChoiceDTOFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final int votes;

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChoiceDTOCopyWith<_ChoiceDTO> get copyWith =>
      __$ChoiceDTOCopyWithImpl<_ChoiceDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChoiceDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChoiceDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.votes, votes) || other.votes == votes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, votes);

  @override
  String toString() {
    return 'ChoiceDTO(id: $id, title: $title, votes: $votes)';
  }
}

/// @nodoc
abstract mixin class _$ChoiceDTOCopyWith<$Res>
    implements $ChoiceDTOCopyWith<$Res> {
  factory _$ChoiceDTOCopyWith(
          _ChoiceDTO value, $Res Function(_ChoiceDTO) _then) =
      __$ChoiceDTOCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String title, int votes});
}

/// @nodoc
class __$ChoiceDTOCopyWithImpl<$Res> implements _$ChoiceDTOCopyWith<$Res> {
  __$ChoiceDTOCopyWithImpl(this._self, this._then);

  final _ChoiceDTO _self;
  final $Res Function(_ChoiceDTO) _then;

  /// Create a copy of ChoiceDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? votes = null,
  }) {
    return _then(_ChoiceDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      votes: null == votes
          ? _self.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
