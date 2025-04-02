// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_stream_infos_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitchStreamInfosDto {
  String get title;
  int get viewerCount;
  bool get isOnline;
  Duration get startedAtDuration;
  bool get isEmoteMode;
  bool get isFollowerMode;
  bool get isSlowMode;
  int get slowModeWaitTime;
  bool get isSubscriberMode;

  /// Create a copy of TwitchStreamInfosDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TwitchStreamInfosDtoCopyWith<TwitchStreamInfosDto> get copyWith =>
      _$TwitchStreamInfosDtoCopyWithImpl<TwitchStreamInfosDto>(
          this as TwitchStreamInfosDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TwitchStreamInfosDto &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.viewerCount, viewerCount) ||
                other.viewerCount == viewerCount) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.startedAtDuration, startedAtDuration) ||
                other.startedAtDuration == startedAtDuration) &&
            (identical(other.isEmoteMode, isEmoteMode) ||
                other.isEmoteMode == isEmoteMode) &&
            (identical(other.isFollowerMode, isFollowerMode) ||
                other.isFollowerMode == isFollowerMode) &&
            (identical(other.isSlowMode, isSlowMode) ||
                other.isSlowMode == isSlowMode) &&
            (identical(other.slowModeWaitTime, slowModeWaitTime) ||
                other.slowModeWaitTime == slowModeWaitTime) &&
            (identical(other.isSubscriberMode, isSubscriberMode) ||
                other.isSubscriberMode == isSubscriberMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      viewerCount,
      isOnline,
      startedAtDuration,
      isEmoteMode,
      isFollowerMode,
      isSlowMode,
      slowModeWaitTime,
      isSubscriberMode);

  @override
  String toString() {
    return 'TwitchStreamInfosDto(title: $title, viewerCount: $viewerCount, isOnline: $isOnline, startedAtDuration: $startedAtDuration, isEmoteMode: $isEmoteMode, isFollowerMode: $isFollowerMode, isSlowMode: $isSlowMode, slowModeWaitTime: $slowModeWaitTime, isSubscriberMode: $isSubscriberMode)';
  }
}

/// @nodoc
abstract mixin class $TwitchStreamInfosDtoCopyWith<$Res> {
  factory $TwitchStreamInfosDtoCopyWith(TwitchStreamInfosDto value,
          $Res Function(TwitchStreamInfosDto) _then) =
      _$TwitchStreamInfosDtoCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      int viewerCount,
      bool isOnline,
      Duration startedAtDuration,
      bool isEmoteMode,
      bool isFollowerMode,
      bool isSlowMode,
      int slowModeWaitTime,
      bool isSubscriberMode});
}

/// @nodoc
class _$TwitchStreamInfosDtoCopyWithImpl<$Res>
    implements $TwitchStreamInfosDtoCopyWith<$Res> {
  _$TwitchStreamInfosDtoCopyWithImpl(this._self, this._then);

  final TwitchStreamInfosDto _self;
  final $Res Function(TwitchStreamInfosDto) _then;

  /// Create a copy of TwitchStreamInfosDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? viewerCount = null,
    Object? isOnline = null,
    Object? startedAtDuration = null,
    Object? isEmoteMode = null,
    Object? isFollowerMode = null,
    Object? isSlowMode = null,
    Object? slowModeWaitTime = null,
    Object? isSubscriberMode = null,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      viewerCount: null == viewerCount
          ? _self.viewerCount
          : viewerCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAtDuration: null == startedAtDuration
          ? _self.startedAtDuration
          : startedAtDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      isEmoteMode: null == isEmoteMode
          ? _self.isEmoteMode
          : isEmoteMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFollowerMode: null == isFollowerMode
          ? _self.isFollowerMode
          : isFollowerMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isSlowMode: null == isSlowMode
          ? _self.isSlowMode
          : isSlowMode // ignore: cast_nullable_to_non_nullable
              as bool,
      slowModeWaitTime: null == slowModeWaitTime
          ? _self.slowModeWaitTime
          : slowModeWaitTime // ignore: cast_nullable_to_non_nullable
              as int,
      isSubscriberMode: null == isSubscriberMode
          ? _self.isSubscriberMode
          : isSubscriberMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _TwitchStreamInfosDto implements TwitchStreamInfosDto {
  const _TwitchStreamInfosDto(
      {required this.title,
      required this.viewerCount,
      required this.isOnline,
      required this.startedAtDuration,
      required this.isEmoteMode,
      required this.isFollowerMode,
      required this.isSlowMode,
      required this.slowModeWaitTime,
      required this.isSubscriberMode});

  @override
  final String title;
  @override
  final int viewerCount;
  @override
  final bool isOnline;
  @override
  final Duration startedAtDuration;
  @override
  final bool isEmoteMode;
  @override
  final bool isFollowerMode;
  @override
  final bool isSlowMode;
  @override
  final int slowModeWaitTime;
  @override
  final bool isSubscriberMode;

  /// Create a copy of TwitchStreamInfosDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TwitchStreamInfosDtoCopyWith<_TwitchStreamInfosDto> get copyWith =>
      __$TwitchStreamInfosDtoCopyWithImpl<_TwitchStreamInfosDto>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TwitchStreamInfosDto &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.viewerCount, viewerCount) ||
                other.viewerCount == viewerCount) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.startedAtDuration, startedAtDuration) ||
                other.startedAtDuration == startedAtDuration) &&
            (identical(other.isEmoteMode, isEmoteMode) ||
                other.isEmoteMode == isEmoteMode) &&
            (identical(other.isFollowerMode, isFollowerMode) ||
                other.isFollowerMode == isFollowerMode) &&
            (identical(other.isSlowMode, isSlowMode) ||
                other.isSlowMode == isSlowMode) &&
            (identical(other.slowModeWaitTime, slowModeWaitTime) ||
                other.slowModeWaitTime == slowModeWaitTime) &&
            (identical(other.isSubscriberMode, isSubscriberMode) ||
                other.isSubscriberMode == isSubscriberMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      viewerCount,
      isOnline,
      startedAtDuration,
      isEmoteMode,
      isFollowerMode,
      isSlowMode,
      slowModeWaitTime,
      isSubscriberMode);

  @override
  String toString() {
    return 'TwitchStreamInfosDto(title: $title, viewerCount: $viewerCount, isOnline: $isOnline, startedAtDuration: $startedAtDuration, isEmoteMode: $isEmoteMode, isFollowerMode: $isFollowerMode, isSlowMode: $isSlowMode, slowModeWaitTime: $slowModeWaitTime, isSubscriberMode: $isSubscriberMode)';
  }
}

/// @nodoc
abstract mixin class _$TwitchStreamInfosDtoCopyWith<$Res>
    implements $TwitchStreamInfosDtoCopyWith<$Res> {
  factory _$TwitchStreamInfosDtoCopyWith(_TwitchStreamInfosDto value,
          $Res Function(_TwitchStreamInfosDto) _then) =
      __$TwitchStreamInfosDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String title,
      int viewerCount,
      bool isOnline,
      Duration startedAtDuration,
      bool isEmoteMode,
      bool isFollowerMode,
      bool isSlowMode,
      int slowModeWaitTime,
      bool isSubscriberMode});
}

/// @nodoc
class __$TwitchStreamInfosDtoCopyWithImpl<$Res>
    implements _$TwitchStreamInfosDtoCopyWith<$Res> {
  __$TwitchStreamInfosDtoCopyWithImpl(this._self, this._then);

  final _TwitchStreamInfosDto _self;
  final $Res Function(_TwitchStreamInfosDto) _then;

  /// Create a copy of TwitchStreamInfosDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? viewerCount = null,
    Object? isOnline = null,
    Object? startedAtDuration = null,
    Object? isEmoteMode = null,
    Object? isFollowerMode = null,
    Object? isSlowMode = null,
    Object? slowModeWaitTime = null,
    Object? isSubscriberMode = null,
  }) {
    return _then(_TwitchStreamInfosDto(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      viewerCount: null == viewerCount
          ? _self.viewerCount
          : viewerCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAtDuration: null == startedAtDuration
          ? _self.startedAtDuration
          : startedAtDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      isEmoteMode: null == isEmoteMode
          ? _self.isEmoteMode
          : isEmoteMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFollowerMode: null == isFollowerMode
          ? _self.isFollowerMode
          : isFollowerMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isSlowMode: null == isSlowMode
          ? _self.isSlowMode
          : isSlowMode // ignore: cast_nullable_to_non_nullable
              as bool,
      slowModeWaitTime: null == slowModeWaitTime
          ? _self.slowModeWaitTime
          : slowModeWaitTime // ignore: cast_nullable_to_non_nullable
              as int,
      isSubscriberMode: null == isSubscriberMode
          ? _self.isSubscriberMode
          : isSubscriberMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
