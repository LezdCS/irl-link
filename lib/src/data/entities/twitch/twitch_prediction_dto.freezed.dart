// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_prediction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TwitchPredictionDTO {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get winningOutcomeId => throw _privateConstructorUsedError;
  int get totalUsers => throw _privateConstructorUsedError;
  List<OutcomeDTO> get outcomes => throw _privateConstructorUsedError;
  PredictionStatus get status => throw _privateConstructorUsedError;
  DateTime get remainingTime => throw _privateConstructorUsedError;

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TwitchPredictionDTOCopyWith<TwitchPredictionDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwitchPredictionDTOCopyWith<$Res> {
  factory $TwitchPredictionDTOCopyWith(
          TwitchPredictionDTO value, $Res Function(TwitchPredictionDTO) then) =
      _$TwitchPredictionDTOCopyWithImpl<$Res, TwitchPredictionDTO>;
  @useResult
  $Res call(
      {String id,
      String title,
      String winningOutcomeId,
      int totalUsers,
      List<OutcomeDTO> outcomes,
      PredictionStatus status,
      DateTime remainingTime});
}

/// @nodoc
class _$TwitchPredictionDTOCopyWithImpl<$Res, $Val extends TwitchPredictionDTO>
    implements $TwitchPredictionDTOCopyWith<$Res> {
  _$TwitchPredictionDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? winningOutcomeId = null,
    Object? totalUsers = null,
    Object? outcomes = null,
    Object? status = null,
    Object? remainingTime = null,
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
      winningOutcomeId: null == winningOutcomeId
          ? _value.winningOutcomeId
          : winningOutcomeId // ignore: cast_nullable_to_non_nullable
              as String,
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      outcomes: null == outcomes
          ? _value.outcomes
          : outcomes // ignore: cast_nullable_to_non_nullable
              as List<OutcomeDTO>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PredictionStatus,
      remainingTime: null == remainingTime
          ? _value.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TwitchPredictionDTOImplCopyWith<$Res>
    implements $TwitchPredictionDTOCopyWith<$Res> {
  factory _$$TwitchPredictionDTOImplCopyWith(_$TwitchPredictionDTOImpl value,
          $Res Function(_$TwitchPredictionDTOImpl) then) =
      __$$TwitchPredictionDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String winningOutcomeId,
      int totalUsers,
      List<OutcomeDTO> outcomes,
      PredictionStatus status,
      DateTime remainingTime});
}

/// @nodoc
class __$$TwitchPredictionDTOImplCopyWithImpl<$Res>
    extends _$TwitchPredictionDTOCopyWithImpl<$Res, _$TwitchPredictionDTOImpl>
    implements _$$TwitchPredictionDTOImplCopyWith<$Res> {
  __$$TwitchPredictionDTOImplCopyWithImpl(_$TwitchPredictionDTOImpl _value,
      $Res Function(_$TwitchPredictionDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? winningOutcomeId = null,
    Object? totalUsers = null,
    Object? outcomes = null,
    Object? status = null,
    Object? remainingTime = null,
  }) {
    return _then(_$TwitchPredictionDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      winningOutcomeId: null == winningOutcomeId
          ? _value.winningOutcomeId
          : winningOutcomeId // ignore: cast_nullable_to_non_nullable
              as String,
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      outcomes: null == outcomes
          ? _value._outcomes
          : outcomes // ignore: cast_nullable_to_non_nullable
              as List<OutcomeDTO>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PredictionStatus,
      remainingTime: null == remainingTime
          ? _value.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TwitchPredictionDTOImpl implements _TwitchPredictionDTO {
  const _$TwitchPredictionDTOImpl(
      {required this.id,
      required this.title,
      required this.winningOutcomeId,
      required this.totalUsers,
      required final List<OutcomeDTO> outcomes,
      required this.status,
      required this.remainingTime})
      : _outcomes = outcomes;

  @override
  final String id;
  @override
  final String title;
  @override
  final String winningOutcomeId;
  @override
  final int totalUsers;
  final List<OutcomeDTO> _outcomes;
  @override
  List<OutcomeDTO> get outcomes {
    if (_outcomes is EqualUnmodifiableListView) return _outcomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outcomes);
  }

  @override
  final PredictionStatus status;
  @override
  final DateTime remainingTime;

  @override
  String toString() {
    return 'TwitchPredictionDTO(id: $id, title: $title, winningOutcomeId: $winningOutcomeId, totalUsers: $totalUsers, outcomes: $outcomes, status: $status, remainingTime: $remainingTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwitchPredictionDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.winningOutcomeId, winningOutcomeId) ||
                other.winningOutcomeId == winningOutcomeId) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            const DeepCollectionEquality().equals(other._outcomes, _outcomes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.remainingTime, remainingTime) ||
                other.remainingTime == remainingTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      winningOutcomeId,
      totalUsers,
      const DeepCollectionEquality().hash(_outcomes),
      status,
      remainingTime);

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TwitchPredictionDTOImplCopyWith<_$TwitchPredictionDTOImpl> get copyWith =>
      __$$TwitchPredictionDTOImplCopyWithImpl<_$TwitchPredictionDTOImpl>(
          this, _$identity);
}

abstract class _TwitchPredictionDTO implements TwitchPredictionDTO {
  const factory _TwitchPredictionDTO(
      {required final String id,
      required final String title,
      required final String winningOutcomeId,
      required final int totalUsers,
      required final List<OutcomeDTO> outcomes,
      required final PredictionStatus status,
      required final DateTime remainingTime}) = _$TwitchPredictionDTOImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get winningOutcomeId;
  @override
  int get totalUsers;
  @override
  List<OutcomeDTO> get outcomes;
  @override
  PredictionStatus get status;
  @override
  DateTime get remainingTime;

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TwitchPredictionDTOImplCopyWith<_$TwitchPredictionDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OutcomeDTO {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get users => throw _privateConstructorUsedError;
  int get channelPoints => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutcomeDTOCopyWith<OutcomeDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutcomeDTOCopyWith<$Res> {
  factory $OutcomeDTOCopyWith(
          OutcomeDTO value, $Res Function(OutcomeDTO) then) =
      _$OutcomeDTOCopyWithImpl<$Res, OutcomeDTO>;
  @useResult
  $Res call(
      {String id, String title, int users, int channelPoints, Color color});
}

/// @nodoc
class _$OutcomeDTOCopyWithImpl<$Res, $Val extends OutcomeDTO>
    implements $OutcomeDTOCopyWith<$Res> {
  _$OutcomeDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? users = null,
    Object? channelPoints = null,
    Object? color = null,
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
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as int,
      channelPoints: null == channelPoints
          ? _value.channelPoints
          : channelPoints // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutcomeDTOImplCopyWith<$Res>
    implements $OutcomeDTOCopyWith<$Res> {
  factory _$$OutcomeDTOImplCopyWith(
          _$OutcomeDTOImpl value, $Res Function(_$OutcomeDTOImpl) then) =
      __$$OutcomeDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String title, int users, int channelPoints, Color color});
}

/// @nodoc
class __$$OutcomeDTOImplCopyWithImpl<$Res>
    extends _$OutcomeDTOCopyWithImpl<$Res, _$OutcomeDTOImpl>
    implements _$$OutcomeDTOImplCopyWith<$Res> {
  __$$OutcomeDTOImplCopyWithImpl(
      _$OutcomeDTOImpl _value, $Res Function(_$OutcomeDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? users = null,
    Object? channelPoints = null,
    Object? color = null,
  }) {
    return _then(_$OutcomeDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as int,
      channelPoints: null == channelPoints
          ? _value.channelPoints
          : channelPoints // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$OutcomeDTOImpl implements _OutcomeDTO {
  const _$OutcomeDTOImpl(
      {required this.id,
      required this.title,
      required this.users,
      required this.channelPoints,
      required this.color});

  @override
  final String id;
  @override
  final String title;
  @override
  final int users;
  @override
  final int channelPoints;
  @override
  final Color color;

  @override
  String toString() {
    return 'OutcomeDTO(id: $id, title: $title, users: $users, channelPoints: $channelPoints, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutcomeDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.users, users) || other.users == users) &&
            (identical(other.channelPoints, channelPoints) ||
                other.channelPoints == channelPoints) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, users, channelPoints, color);

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutcomeDTOImplCopyWith<_$OutcomeDTOImpl> get copyWith =>
      __$$OutcomeDTOImplCopyWithImpl<_$OutcomeDTOImpl>(this, _$identity);
}

abstract class _OutcomeDTO implements OutcomeDTO {
  const factory _OutcomeDTO(
      {required final String id,
      required final String title,
      required final int users,
      required final int channelPoints,
      required final Color color}) = _$OutcomeDTOImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  int get users;
  @override
  int get channelPoints;
  @override
  Color get color;

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutcomeDTOImplCopyWith<_$OutcomeDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
