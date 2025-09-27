// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_prediction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitchPredictionDTO {
  String get id;
  String get title;
  String get winningOutcomeId;
  int get totalUsers;
  List<OutcomeDTO> get outcomes;
  PredictionStatus get status;
  DateTime get remainingTime;

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TwitchPredictionDTOCopyWith<TwitchPredictionDTO> get copyWith =>
      _$TwitchPredictionDTOCopyWithImpl<TwitchPredictionDTO>(
          this as TwitchPredictionDTO, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TwitchPredictionDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.winningOutcomeId, winningOutcomeId) ||
                other.winningOutcomeId == winningOutcomeId) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            const DeepCollectionEquality().equals(other.outcomes, outcomes) &&
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
      const DeepCollectionEquality().hash(outcomes),
      status,
      remainingTime);

  @override
  String toString() {
    return 'TwitchPredictionDTO(id: $id, title: $title, winningOutcomeId: $winningOutcomeId, totalUsers: $totalUsers, outcomes: $outcomes, status: $status, remainingTime: $remainingTime)';
  }
}

/// @nodoc
abstract mixin class $TwitchPredictionDTOCopyWith<$Res> {
  factory $TwitchPredictionDTOCopyWith(
          TwitchPredictionDTO value, $Res Function(TwitchPredictionDTO) _then) =
      _$TwitchPredictionDTOCopyWithImpl;
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
class _$TwitchPredictionDTOCopyWithImpl<$Res>
    implements $TwitchPredictionDTOCopyWith<$Res> {
  _$TwitchPredictionDTOCopyWithImpl(this._self, this._then);

  final TwitchPredictionDTO _self;
  final $Res Function(TwitchPredictionDTO) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      winningOutcomeId: null == winningOutcomeId
          ? _self.winningOutcomeId
          : winningOutcomeId // ignore: cast_nullable_to_non_nullable
              as String,
      totalUsers: null == totalUsers
          ? _self.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      outcomes: null == outcomes
          ? _self.outcomes
          : outcomes // ignore: cast_nullable_to_non_nullable
              as List<OutcomeDTO>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PredictionStatus,
      remainingTime: null == remainingTime
          ? _self.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [TwitchPredictionDTO].
extension TwitchPredictionDTOPatterns on TwitchPredictionDTO {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TwitchPredictionDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TwitchPredictionDTO() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TwitchPredictionDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchPredictionDTO():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TwitchPredictionDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchPredictionDTO() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String winningOutcomeId,
            int totalUsers,
            List<OutcomeDTO> outcomes,
            PredictionStatus status,
            DateTime remainingTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TwitchPredictionDTO() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.winningOutcomeId,
            _that.totalUsers,
            _that.outcomes,
            _that.status,
            _that.remainingTime);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String winningOutcomeId,
            int totalUsers,
            List<OutcomeDTO> outcomes,
            PredictionStatus status,
            DateTime remainingTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchPredictionDTO():
        return $default(
            _that.id,
            _that.title,
            _that.winningOutcomeId,
            _that.totalUsers,
            _that.outcomes,
            _that.status,
            _that.remainingTime);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String title,
            String winningOutcomeId,
            int totalUsers,
            List<OutcomeDTO> outcomes,
            PredictionStatus status,
            DateTime remainingTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchPredictionDTO() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.winningOutcomeId,
            _that.totalUsers,
            _that.outcomes,
            _that.status,
            _that.remainingTime);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TwitchPredictionDTO implements TwitchPredictionDTO {
  const _TwitchPredictionDTO(
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

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TwitchPredictionDTOCopyWith<_TwitchPredictionDTO> get copyWith =>
      __$TwitchPredictionDTOCopyWithImpl<_TwitchPredictionDTO>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TwitchPredictionDTO &&
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

  @override
  String toString() {
    return 'TwitchPredictionDTO(id: $id, title: $title, winningOutcomeId: $winningOutcomeId, totalUsers: $totalUsers, outcomes: $outcomes, status: $status, remainingTime: $remainingTime)';
  }
}

/// @nodoc
abstract mixin class _$TwitchPredictionDTOCopyWith<$Res>
    implements $TwitchPredictionDTOCopyWith<$Res> {
  factory _$TwitchPredictionDTOCopyWith(_TwitchPredictionDTO value,
          $Res Function(_TwitchPredictionDTO) _then) =
      __$TwitchPredictionDTOCopyWithImpl;
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
class __$TwitchPredictionDTOCopyWithImpl<$Res>
    implements _$TwitchPredictionDTOCopyWith<$Res> {
  __$TwitchPredictionDTOCopyWithImpl(this._self, this._then);

  final _TwitchPredictionDTO _self;
  final $Res Function(_TwitchPredictionDTO) _then;

  /// Create a copy of TwitchPredictionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? winningOutcomeId = null,
    Object? totalUsers = null,
    Object? outcomes = null,
    Object? status = null,
    Object? remainingTime = null,
  }) {
    return _then(_TwitchPredictionDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      winningOutcomeId: null == winningOutcomeId
          ? _self.winningOutcomeId
          : winningOutcomeId // ignore: cast_nullable_to_non_nullable
              as String,
      totalUsers: null == totalUsers
          ? _self.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      outcomes: null == outcomes
          ? _self._outcomes
          : outcomes // ignore: cast_nullable_to_non_nullable
              as List<OutcomeDTO>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PredictionStatus,
      remainingTime: null == remainingTime
          ? _self.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$OutcomeDTO {
  String get id;
  String get title;
  int get users;
  @JsonKey(name: 'channel_points')
  int get channelPoints;
  @ColorConverter()
  Color get color;

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutcomeDTOCopyWith<OutcomeDTO> get copyWith =>
      _$OutcomeDTOCopyWithImpl<OutcomeDTO>(this as OutcomeDTO, _$identity);

  /// Serializes this OutcomeDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OutcomeDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.users, users) || other.users == users) &&
            (identical(other.channelPoints, channelPoints) ||
                other.channelPoints == channelPoints) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, users, channelPoints, color);

  @override
  String toString() {
    return 'OutcomeDTO(id: $id, title: $title, users: $users, channelPoints: $channelPoints, color: $color)';
  }
}

/// @nodoc
abstract mixin class $OutcomeDTOCopyWith<$Res> {
  factory $OutcomeDTOCopyWith(
          OutcomeDTO value, $Res Function(OutcomeDTO) _then) =
      _$OutcomeDTOCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      int users,
      @JsonKey(name: 'channel_points') int channelPoints,
      @ColorConverter() Color color});
}

/// @nodoc
class _$OutcomeDTOCopyWithImpl<$Res> implements $OutcomeDTOCopyWith<$Res> {
  _$OutcomeDTOCopyWithImpl(this._self, this._then);

  final OutcomeDTO _self;
  final $Res Function(OutcomeDTO) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _self.users
          : users // ignore: cast_nullable_to_non_nullable
              as int,
      channelPoints: null == channelPoints
          ? _self.channelPoints
          : channelPoints // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// Adds pattern-matching-related methods to [OutcomeDTO].
extension OutcomeDTOPatterns on OutcomeDTO {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_OutcomeDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutcomeDTO() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_OutcomeDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomeDTO():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_OutcomeDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomeDTO() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            int users,
            @JsonKey(name: 'channel_points') int channelPoints,
            @ColorConverter() Color color)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutcomeDTO() when $default != null:
        return $default(_that.id, _that.title, _that.users, _that.channelPoints,
            _that.color);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            int users,
            @JsonKey(name: 'channel_points') int channelPoints,
            @ColorConverter() Color color)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomeDTO():
        return $default(_that.id, _that.title, _that.users, _that.channelPoints,
            _that.color);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String title,
            int users,
            @JsonKey(name: 'channel_points') int channelPoints,
            @ColorConverter() Color color)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomeDTO() when $default != null:
        return $default(_that.id, _that.title, _that.users, _that.channelPoints,
            _that.color);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OutcomeDTO implements OutcomeDTO {
  const _OutcomeDTO(
      {required this.id,
      required this.title,
      this.users = 0,
      @JsonKey(name: 'channel_points') this.channelPoints = 0,
      @ColorConverter() required this.color});
  factory _OutcomeDTO.fromJson(Map<String, dynamic> json) =>
      _$OutcomeDTOFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final int users;
  @override
  @JsonKey(name: 'channel_points')
  final int channelPoints;
  @override
  @ColorConverter()
  final Color color;

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutcomeDTOCopyWith<_OutcomeDTO> get copyWith =>
      __$OutcomeDTOCopyWithImpl<_OutcomeDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OutcomeDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OutcomeDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.users, users) || other.users == users) &&
            (identical(other.channelPoints, channelPoints) ||
                other.channelPoints == channelPoints) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, users, channelPoints, color);

  @override
  String toString() {
    return 'OutcomeDTO(id: $id, title: $title, users: $users, channelPoints: $channelPoints, color: $color)';
  }
}

/// @nodoc
abstract mixin class _$OutcomeDTOCopyWith<$Res>
    implements $OutcomeDTOCopyWith<$Res> {
  factory _$OutcomeDTOCopyWith(
          _OutcomeDTO value, $Res Function(_OutcomeDTO) _then) =
      __$OutcomeDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      int users,
      @JsonKey(name: 'channel_points') int channelPoints,
      @ColorConverter() Color color});
}

/// @nodoc
class __$OutcomeDTOCopyWithImpl<$Res> implements _$OutcomeDTOCopyWith<$Res> {
  __$OutcomeDTOCopyWithImpl(this._self, this._then);

  final _OutcomeDTO _self;
  final $Res Function(_OutcomeDTO) _then;

  /// Create a copy of OutcomeDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? users = null,
    Object? channelPoints = null,
    Object? color = null,
  }) {
    return _then(_OutcomeDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _self.users
          : users // ignore: cast_nullable_to_non_nullable
              as int,
      channelPoints: null == channelPoints
          ? _self.channelPoints
          : channelPoints // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

// dart format on
