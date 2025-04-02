// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_hype_train_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitchHypeTrainDTO {
  String get id;
  int get total;
  int get progress;
  int get goal;
  int get level;
  List<ContributionDTO> get topContributions;
  ContributionDTO? get lastContribution;
  DateTime get endsAt;

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TwitchHypeTrainDTOCopyWith<TwitchHypeTrainDTO> get copyWith =>
      _$TwitchHypeTrainDTOCopyWithImpl<TwitchHypeTrainDTO>(
          this as TwitchHypeTrainDTO, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TwitchHypeTrainDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality()
                .equals(other.topContributions, topContributions) &&
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
      const DeepCollectionEquality().hash(topContributions),
      lastContribution,
      endsAt);

  @override
  String toString() {
    return 'TwitchHypeTrainDTO(id: $id, total: $total, progress: $progress, goal: $goal, level: $level, topContributions: $topContributions, lastContribution: $lastContribution, endsAt: $endsAt)';
  }
}

/// @nodoc
abstract mixin class $TwitchHypeTrainDTOCopyWith<$Res> {
  factory $TwitchHypeTrainDTOCopyWith(
          TwitchHypeTrainDTO value, $Res Function(TwitchHypeTrainDTO) _then) =
      _$TwitchHypeTrainDTOCopyWithImpl;
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
class _$TwitchHypeTrainDTOCopyWithImpl<$Res>
    implements $TwitchHypeTrainDTOCopyWith<$Res> {
  _$TwitchHypeTrainDTOCopyWithImpl(this._self, this._then);

  final TwitchHypeTrainDTO _self;
  final $Res Function(TwitchHypeTrainDTO) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      goal: null == goal
          ? _self.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      topContributions: null == topContributions
          ? _self.topContributions
          : topContributions // ignore: cast_nullable_to_non_nullable
              as List<ContributionDTO>,
      lastContribution: freezed == lastContribution
          ? _self.lastContribution
          : lastContribution // ignore: cast_nullable_to_non_nullable
              as ContributionDTO?,
      endsAt: null == endsAt
          ? _self.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContributionDTOCopyWith<$Res>? get lastContribution {
    if (_self.lastContribution == null) {
      return null;
    }

    return $ContributionDTOCopyWith<$Res>(_self.lastContribution!, (value) {
      return _then(_self.copyWith(lastContribution: value));
    });
  }
}

/// @nodoc

class _TwitchHypeTrainDTO implements TwitchHypeTrainDTO {
  const _TwitchHypeTrainDTO(
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

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TwitchHypeTrainDTOCopyWith<_TwitchHypeTrainDTO> get copyWith =>
      __$TwitchHypeTrainDTOCopyWithImpl<_TwitchHypeTrainDTO>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TwitchHypeTrainDTO &&
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

  @override
  String toString() {
    return 'TwitchHypeTrainDTO(id: $id, total: $total, progress: $progress, goal: $goal, level: $level, topContributions: $topContributions, lastContribution: $lastContribution, endsAt: $endsAt)';
  }
}

/// @nodoc
abstract mixin class _$TwitchHypeTrainDTOCopyWith<$Res>
    implements $TwitchHypeTrainDTOCopyWith<$Res> {
  factory _$TwitchHypeTrainDTOCopyWith(
          _TwitchHypeTrainDTO value, $Res Function(_TwitchHypeTrainDTO) _then) =
      __$TwitchHypeTrainDTOCopyWithImpl;
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
class __$TwitchHypeTrainDTOCopyWithImpl<$Res>
    implements _$TwitchHypeTrainDTOCopyWith<$Res> {
  __$TwitchHypeTrainDTOCopyWithImpl(this._self, this._then);

  final _TwitchHypeTrainDTO _self;
  final $Res Function(_TwitchHypeTrainDTO) _then;

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_TwitchHypeTrainDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      goal: null == goal
          ? _self.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      topContributions: null == topContributions
          ? _self._topContributions
          : topContributions // ignore: cast_nullable_to_non_nullable
              as List<ContributionDTO>,
      lastContribution: freezed == lastContribution
          ? _self.lastContribution
          : lastContribution // ignore: cast_nullable_to_non_nullable
              as ContributionDTO?,
      endsAt: null == endsAt
          ? _self.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of TwitchHypeTrainDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContributionDTOCopyWith<$Res>? get lastContribution {
    if (_self.lastContribution == null) {
      return null;
    }

    return $ContributionDTOCopyWith<$Res>(_self.lastContribution!, (value) {
      return _then(_self.copyWith(lastContribution: value));
    });
  }
}

/// @nodoc
mixin _$ContributionDTO {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'user_login')
  String get userLogin;
  @JsonKey(name: 'user_name')
  String get userName;
  String get type;
  int get total;

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContributionDTOCopyWith<ContributionDTO> get copyWith =>
      _$ContributionDTOCopyWithImpl<ContributionDTO>(
          this as ContributionDTO, _$identity);

  /// Serializes this ContributionDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContributionDTO &&
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

  @override
  String toString() {
    return 'ContributionDTO(userId: $userId, userLogin: $userLogin, userName: $userName, type: $type, total: $total)';
  }
}

/// @nodoc
abstract mixin class $ContributionDTOCopyWith<$Res> {
  factory $ContributionDTOCopyWith(
          ContributionDTO value, $Res Function(ContributionDTO) _then) =
      _$ContributionDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'user_login') String userLogin,
      @JsonKey(name: 'user_name') String userName,
      String type,
      int total});
}

/// @nodoc
class _$ContributionDTOCopyWithImpl<$Res>
    implements $ContributionDTOCopyWith<$Res> {
  _$ContributionDTOCopyWithImpl(this._self, this._then);

  final ContributionDTO _self;
  final $Res Function(ContributionDTO) _then;

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
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userLogin: null == userLogin
          ? _self.userLogin
          : userLogin // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ContributionDTO implements ContributionDTO {
  const _ContributionDTO(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_login') required this.userLogin,
      @JsonKey(name: 'user_name') required this.userName,
      required this.type,
      required this.total});
  factory _ContributionDTO.fromJson(Map<String, dynamic> json) =>
      _$ContributionDTOFromJson(json);

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

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContributionDTOCopyWith<_ContributionDTO> get copyWith =>
      __$ContributionDTOCopyWithImpl<_ContributionDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContributionDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContributionDTO &&
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

  @override
  String toString() {
    return 'ContributionDTO(userId: $userId, userLogin: $userLogin, userName: $userName, type: $type, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$ContributionDTOCopyWith<$Res>
    implements $ContributionDTOCopyWith<$Res> {
  factory _$ContributionDTOCopyWith(
          _ContributionDTO value, $Res Function(_ContributionDTO) _then) =
      __$ContributionDTOCopyWithImpl;
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
class __$ContributionDTOCopyWithImpl<$Res>
    implements _$ContributionDTOCopyWith<$Res> {
  __$ContributionDTOCopyWithImpl(this._self, this._then);

  final _ContributionDTO _self;
  final $Res Function(_ContributionDTO) _then;

  /// Create a copy of ContributionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? userLogin = null,
    Object? userName = null,
    Object? type = null,
    Object? total = null,
  }) {
    return _then(_ContributionDTO(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userLogin: null == userLogin
          ? _self.userLogin
          : userLogin // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
