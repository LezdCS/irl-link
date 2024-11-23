// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_hype_train_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TwitchHypeTrainDTO {
  String get id => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  int get goal => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  List<ContributionDTO> get topContributions =>
      throw _privateConstructorUsedError;
  ContributionDTO? get lastContribution => throw _privateConstructorUsedError;
  DateTime get endsAt => throw _privateConstructorUsedError;

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TwitchHypeTrainDTOCopyWith<TwitchHypeTrainDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwitchHypeTrainDTOCopyWith<$Res> {
  factory $TwitchHypeTrainDTOCopyWith(
          TwitchHypeTrainDTO value, $Res Function(TwitchHypeTrainDTO) then) =
      _$TwitchHypeTrainDTOCopyWithImpl<$Res, TwitchHypeTrainDTO>;
  @useResult
  $Res call(
      {String id,
      int total,
      int progress,
      int goal,
      int level,
      List<ContributionDTO> topContributions,
      ContributionDTO? lastContribution,
      DateTime endsAt});

  $ContributionDTOCopyWith<$Res>? get lastContribution;
}

/// @nodoc
class _$TwitchHypeTrainDTOCopyWithImpl<$Res, $Val extends TwitchHypeTrainDTO>
    implements $TwitchHypeTrainDTOCopyWith<$Res> {
  _$TwitchHypeTrainDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? total = null,
    Object? progress = null,
    Object? goal = null,
    Object? level = null,
    Object? topContributions = null,
    Object? lastContribution = freezed,
    Object? endsAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      topContributions: null == topContributions
          ? _value.topContributions
          : topContributions // ignore: cast_nullable_to_non_nullable
              as List<ContributionDTO>,
      lastContribution: freezed == lastContribution
          ? _value.lastContribution
          : lastContribution // ignore: cast_nullable_to_non_nullable
              as ContributionDTO?,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContributionDTOCopyWith<$Res>? get lastContribution {
    if (_value.lastContribution == null) {
      return null;
    }

    return $ContributionDTOCopyWith<$Res>(_value.lastContribution!, (value) {
      return _then(_value.copyWith(lastContribution: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TwitchHypeTrainDTOImplCopyWith<$Res>
    implements $TwitchHypeTrainDTOCopyWith<$Res> {
  factory _$$TwitchHypeTrainDTOImplCopyWith(_$TwitchHypeTrainDTOImpl value,
          $Res Function(_$TwitchHypeTrainDTOImpl) then) =
      __$$TwitchHypeTrainDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int total,
      int progress,
      int goal,
      int level,
      List<ContributionDTO> topContributions,
      ContributionDTO? lastContribution,
      DateTime endsAt});

  @override
  $ContributionDTOCopyWith<$Res>? get lastContribution;
}

/// @nodoc
class __$$TwitchHypeTrainDTOImplCopyWithImpl<$Res>
    extends _$TwitchHypeTrainDTOCopyWithImpl<$Res, _$TwitchHypeTrainDTOImpl>
    implements _$$TwitchHypeTrainDTOImplCopyWith<$Res> {
  __$$TwitchHypeTrainDTOImplCopyWithImpl(_$TwitchHypeTrainDTOImpl _value,
      $Res Function(_$TwitchHypeTrainDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? total = null,
    Object? progress = null,
    Object? goal = null,
    Object? level = null,
    Object? topContributions = null,
    Object? lastContribution = freezed,
    Object? endsAt = null,
  }) {
    return _then(_$TwitchHypeTrainDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      topContributions: null == topContributions
          ? _value._topContributions
          : topContributions // ignore: cast_nullable_to_non_nullable
              as List<ContributionDTO>,
      lastContribution: freezed == lastContribution
          ? _value.lastContribution
          : lastContribution // ignore: cast_nullable_to_non_nullable
              as ContributionDTO?,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TwitchHypeTrainDTOImpl implements _TwitchHypeTrainDTO {
  const _$TwitchHypeTrainDTOImpl(
      {required this.id,
      required this.total,
      required this.progress,
      required this.goal,
      required this.level,
      required final List<ContributionDTO> topContributions,
      required this.lastContribution,
      required this.endsAt})
      : _topContributions = topContributions;

  @override
  final String id;
  @override
  final int total;
  @override
  final int progress;
  @override
  final int goal;
  @override
  final int level;
  final List<ContributionDTO> _topContributions;
  @override
  List<ContributionDTO> get topContributions {
    if (_topContributions is EqualUnmodifiableListView)
      return _topContributions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topContributions);
  }

  @override
  final ContributionDTO? lastContribution;
  @override
  final DateTime endsAt;

  @override
  String toString() {
    return 'TwitchHypeTrainDTO(id: $id, total: $total, progress: $progress, goal: $goal, level: $level, topContributions: $topContributions, lastContribution: $lastContribution, endsAt: $endsAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwitchHypeTrainDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality()
                .equals(other._topContributions, _topContributions) &&
            (identical(other.lastContribution, lastContribution) ||
                other.lastContribution == lastContribution) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      total,
      progress,
      goal,
      level,
      const DeepCollectionEquality().hash(_topContributions),
      lastContribution,
      endsAt);

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TwitchHypeTrainDTOImplCopyWith<_$TwitchHypeTrainDTOImpl> get copyWith =>
      __$$TwitchHypeTrainDTOImplCopyWithImpl<_$TwitchHypeTrainDTOImpl>(
          this, _$identity);
}

abstract class _TwitchHypeTrainDTO implements TwitchHypeTrainDTO {
  const factory _TwitchHypeTrainDTO(
      {required final String id,
      required final int total,
      required final int progress,
      required final int goal,
      required final int level,
      required final List<ContributionDTO> topContributions,
      required final ContributionDTO? lastContribution,
      required final DateTime endsAt}) = _$TwitchHypeTrainDTOImpl;

  @override
  String get id;
  @override
  int get total;
  @override
  int get progress;
  @override
  int get goal;
  @override
  int get level;
  @override
  List<ContributionDTO> get topContributions;
  @override
  ContributionDTO? get lastContribution;
  @override
  DateTime get endsAt;

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TwitchHypeTrainDTOImplCopyWith<_$TwitchHypeTrainDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContributionDTO _$ContributionDTOFromJson(Map<String, dynamic> json) {
  return _ContributionDTO.fromJson(json);
}

/// @nodoc
mixin _$ContributionDTO {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_login')
  String get userLogin => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String get userName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this ContributionDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContributionDTOCopyWith<ContributionDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContributionDTOCopyWith<$Res> {
  factory $ContributionDTOCopyWith(
          ContributionDTO value, $Res Function(ContributionDTO) then) =
      _$ContributionDTOCopyWithImpl<$Res, ContributionDTO>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'user_login') String userLogin,
      @JsonKey(name: 'user_name') String userName,
      String type,
      int total});
}

/// @nodoc
class _$ContributionDTOCopyWithImpl<$Res, $Val extends ContributionDTO>
    implements $ContributionDTOCopyWith<$Res> {
  _$ContributionDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userLogin = null,
    Object? userName = null,
    Object? type = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userLogin: null == userLogin
          ? _value.userLogin
          : userLogin // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContributionDTOImplCopyWith<$Res>
    implements $ContributionDTOCopyWith<$Res> {
  factory _$$ContributionDTOImplCopyWith(_$ContributionDTOImpl value,
          $Res Function(_$ContributionDTOImpl) then) =
      __$$ContributionDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'user_login') String userLogin,
      @JsonKey(name: 'user_name') String userName,
      String type,
      int total});
}

/// @nodoc
class __$$ContributionDTOImplCopyWithImpl<$Res>
    extends _$ContributionDTOCopyWithImpl<$Res, _$ContributionDTOImpl>
    implements _$$ContributionDTOImplCopyWith<$Res> {
  __$$ContributionDTOImplCopyWithImpl(
      _$ContributionDTOImpl _value, $Res Function(_$ContributionDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userLogin = null,
    Object? userName = null,
    Object? type = null,
    Object? total = null,
  }) {
    return _then(_$ContributionDTOImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userLogin: null == userLogin
          ? _value.userLogin
          : userLogin // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContributionDTOImpl implements _ContributionDTO {
  const _$ContributionDTOImpl(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_login') required this.userLogin,
      @JsonKey(name: 'user_name') required this.userName,
      required this.type,
      required this.total});

  factory _$ContributionDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContributionDTOImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'user_login')
  final String userLogin;
  @override
  @JsonKey(name: 'user_name')
  final String userName;
  @override
  final String type;
  @override
  final int total;

  @override
  String toString() {
    return 'ContributionDTO(userId: $userId, userLogin: $userLogin, userName: $userName, type: $type, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributionDTOImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userLogin, userLogin) ||
                other.userLogin == userLogin) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, userLogin, userName, type, total);

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributionDTOImplCopyWith<_$ContributionDTOImpl> get copyWith =>
      __$$ContributionDTOImplCopyWithImpl<_$ContributionDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContributionDTOImplToJson(
      this,
    );
  }
}

abstract class _ContributionDTO implements ContributionDTO {
  const factory _ContributionDTO(
      {@JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'user_login') required final String userLogin,
      @JsonKey(name: 'user_name') required final String userName,
      required final String type,
      required final int total}) = _$ContributionDTOImpl;

  factory _ContributionDTO.fromJson(Map<String, dynamic> json) =
      _$ContributionDTOImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'user_login')
  String get userLogin;
  @override
  @JsonKey(name: 'user_name')
  String get userName;
  @override
  String get type;
  @override
  int get total;

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContributionDTOImplCopyWith<_$ContributionDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
