// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardEventDTO {
  int? get id;
  String get title;
  @ColorConverter()
  Color get color;
  @JsonKey(name: 'dashboard_actions_type')
  DashboardActionsTypes get dashboardActionsType;
  SupportedEvents
      get event; // The customValue needs to be dynamic since it can be of different types
// depending on the event type
// ignore: avoid_annotating_with_dynamic
  @JsonKey(name: 'custom_value')
  dynamic get customValue;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardEventDTOCopyWith<DashboardEventDTO> get copyWith =>
      _$DashboardEventDTOCopyWithImpl<DashboardEventDTO>(
          this as DashboardEventDTO, _$identity);

  /// Serializes this DashboardEventDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardEventDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.dashboardActionsType, dashboardActionsType) ||
                other.dashboardActionsType == dashboardActionsType) &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality()
                .equals(other.customValue, customValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      color,
      dashboardActionsType,
      event,
      const DeepCollectionEquality().hash(customValue));

  @override
  String toString() {
    return 'DashboardEventDTO(id: $id, title: $title, color: $color, dashboardActionsType: $dashboardActionsType, event: $event, customValue: $customValue)';
  }
}

/// @nodoc
abstract mixin class $DashboardEventDTOCopyWith<$Res> {
  factory $DashboardEventDTOCopyWith(
          DashboardEventDTO value, $Res Function(DashboardEventDTO) _then) =
      _$DashboardEventDTOCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String title,
      @ColorConverter() Color color,
      @JsonKey(name: 'dashboard_actions_type')
      DashboardActionsTypes dashboardActionsType,
      SupportedEvents event,
      @JsonKey(name: 'custom_value') dynamic customValue});
}

/// @nodoc
class _$DashboardEventDTOCopyWithImpl<$Res>
    implements $DashboardEventDTOCopyWith<$Res> {
  _$DashboardEventDTOCopyWithImpl(this._self, this._then);

  final DashboardEventDTO _self;
  final $Res Function(DashboardEventDTO) _then;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? color = null,
    Object? dashboardActionsType = null,
    Object? event = null,
    Object? customValue = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dashboardActionsType: null == dashboardActionsType
          ? _self.dashboardActionsType
          : dashboardActionsType // ignore: cast_nullable_to_non_nullable
              as DashboardActionsTypes,
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as SupportedEvents,
      customValue: freezed == customValue
          ? _self.customValue
          : customValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// Adds pattern-matching-related methods to [DashboardEventDTO].
extension DashboardEventDTOPatterns on DashboardEventDTO {
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
    TResult Function(_DashboardEventDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardEventDTO() when $default != null:
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
    TResult Function(_DashboardEventDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardEventDTO():
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
    TResult? Function(_DashboardEventDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardEventDTO() when $default != null:
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
            int? id,
            String title,
            @ColorConverter() Color color,
            @JsonKey(name: 'dashboard_actions_type')
            DashboardActionsTypes dashboardActionsType,
            SupportedEvents event,
            @JsonKey(name: 'custom_value') dynamic customValue)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardEventDTO() when $default != null:
        return $default(_that.id, _that.title, _that.color,
            _that.dashboardActionsType, _that.event, _that.customValue);
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
            int? id,
            String title,
            @ColorConverter() Color color,
            @JsonKey(name: 'dashboard_actions_type')
            DashboardActionsTypes dashboardActionsType,
            SupportedEvents event,
            @JsonKey(name: 'custom_value') dynamic customValue)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardEventDTO():
        return $default(_that.id, _that.title, _that.color,
            _that.dashboardActionsType, _that.event, _that.customValue);
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
            int? id,
            String title,
            @ColorConverter() Color color,
            @JsonKey(name: 'dashboard_actions_type')
            DashboardActionsTypes dashboardActionsType,
            SupportedEvents event,
            @JsonKey(name: 'custom_value') dynamic customValue)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardEventDTO() when $default != null:
        return $default(_that.id, _that.title, _that.color,
            _that.dashboardActionsType, _that.event, _that.customValue);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DashboardEventDTO implements DashboardEventDTO {
  const _DashboardEventDTO(
      {this.id,
      this.title = 'None',
      @ColorConverter() required this.color,
      @JsonKey(name: 'dashboard_actions_type')
      required this.dashboardActionsType,
      required this.event,
      @JsonKey(name: 'custom_value') required this.customValue});
  factory _DashboardEventDTO.fromJson(Map<String, dynamic> json) =>
      _$DashboardEventDTOFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey()
  final String title;
  @override
  @ColorConverter()
  final Color color;
  @override
  @JsonKey(name: 'dashboard_actions_type')
  final DashboardActionsTypes dashboardActionsType;
  @override
  final SupportedEvents event;
// The customValue needs to be dynamic since it can be of different types
// depending on the event type
// ignore: avoid_annotating_with_dynamic
  @override
  @JsonKey(name: 'custom_value')
  final dynamic customValue;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardEventDTOCopyWith<_DashboardEventDTO> get copyWith =>
      __$DashboardEventDTOCopyWithImpl<_DashboardEventDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DashboardEventDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardEventDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.dashboardActionsType, dashboardActionsType) ||
                other.dashboardActionsType == dashboardActionsType) &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality()
                .equals(other.customValue, customValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      color,
      dashboardActionsType,
      event,
      const DeepCollectionEquality().hash(customValue));

  @override
  String toString() {
    return 'DashboardEventDTO(id: $id, title: $title, color: $color, dashboardActionsType: $dashboardActionsType, event: $event, customValue: $customValue)';
  }
}

/// @nodoc
abstract mixin class _$DashboardEventDTOCopyWith<$Res>
    implements $DashboardEventDTOCopyWith<$Res> {
  factory _$DashboardEventDTOCopyWith(
          _DashboardEventDTO value, $Res Function(_DashboardEventDTO) _then) =
      __$DashboardEventDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      @ColorConverter() Color color,
      @JsonKey(name: 'dashboard_actions_type')
      DashboardActionsTypes dashboardActionsType,
      SupportedEvents event,
      @JsonKey(name: 'custom_value') dynamic customValue});
}

/// @nodoc
class __$DashboardEventDTOCopyWithImpl<$Res>
    implements _$DashboardEventDTOCopyWith<$Res> {
  __$DashboardEventDTOCopyWithImpl(this._self, this._then);

  final _DashboardEventDTO _self;
  final $Res Function(_DashboardEventDTO) _then;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? color = null,
    Object? dashboardActionsType = null,
    Object? event = null,
    Object? customValue = freezed,
  }) {
    return _then(_DashboardEventDTO(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dashboardActionsType: null == dashboardActionsType
          ? _self.dashboardActionsType
          : dashboardActionsType // ignore: cast_nullable_to_non_nullable
              as DashboardActionsTypes,
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as SupportedEvents,
      customValue: freezed == customValue
          ? _self.customValue
          : customValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

// dart format on
