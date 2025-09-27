// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'se_activity_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeActivityDTO {
  String get id;
  String get channel;
  String get username;
  ActivityType get activityType;
  StreamProvider get provider;
  String? get message;
  String? get amount;
  String? get tier;
  bool? get gifted;
  String? get sender;
  String? get currency;
  bool? get isTest;

  /// Create a copy of SeActivityDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeActivityDTOCopyWith<SeActivityDTO> get copyWith =>
      _$SeActivityDTOCopyWithImpl<SeActivityDTO>(
          this as SeActivityDTO, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeActivityDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.gifted, gifted) || other.gifted == gifted) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.isTest, isTest) || other.isTest == isTest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      channel,
      username,
      activityType,
      provider,
      message,
      amount,
      tier,
      gifted,
      sender,
      currency,
      isTest);

  @override
  String toString() {
    return 'SeActivityDTO(id: $id, channel: $channel, username: $username, activityType: $activityType, provider: $provider, message: $message, amount: $amount, tier: $tier, gifted: $gifted, sender: $sender, currency: $currency, isTest: $isTest)';
  }
}

/// @nodoc
abstract mixin class $SeActivityDTOCopyWith<$Res> {
  factory $SeActivityDTOCopyWith(
          SeActivityDTO value, $Res Function(SeActivityDTO) _then) =
      _$SeActivityDTOCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String channel,
      String username,
      ActivityType activityType,
      StreamProvider provider,
      String? message,
      String? amount,
      String? tier,
      bool? gifted,
      String? sender,
      String? currency,
      bool? isTest});
}

/// @nodoc
class _$SeActivityDTOCopyWithImpl<$Res>
    implements $SeActivityDTOCopyWith<$Res> {
  _$SeActivityDTOCopyWithImpl(this._self, this._then);

  final SeActivityDTO _self;
  final $Res Function(SeActivityDTO) _then;

  /// Create a copy of SeActivityDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channel = null,
    Object? username = null,
    Object? activityType = null,
    Object? provider = null,
    Object? message = freezed,
    Object? amount = freezed,
    Object? tier = freezed,
    Object? gifted = freezed,
    Object? sender = freezed,
    Object? currency = freezed,
    Object? isTest = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _self.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as StreamProvider,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
      gifted: freezed == gifted
          ? _self.gifted
          : gifted // ignore: cast_nullable_to_non_nullable
              as bool?,
      sender: freezed == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      isTest: freezed == isTest
          ? _self.isTest
          : isTest // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeActivityDTO].
extension SeActivityDTOPatterns on SeActivityDTO {
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
    TResult Function(_SeActivityDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeActivityDTO() when $default != null:
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
    TResult Function(_SeActivityDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeActivityDTO():
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
    TResult? Function(_SeActivityDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeActivityDTO() when $default != null:
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
            String channel,
            String username,
            ActivityType activityType,
            StreamProvider provider,
            String? message,
            String? amount,
            String? tier,
            bool? gifted,
            String? sender,
            String? currency,
            bool? isTest)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeActivityDTO() when $default != null:
        return $default(
            _that.id,
            _that.channel,
            _that.username,
            _that.activityType,
            _that.provider,
            _that.message,
            _that.amount,
            _that.tier,
            _that.gifted,
            _that.sender,
            _that.currency,
            _that.isTest);
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
            String channel,
            String username,
            ActivityType activityType,
            StreamProvider provider,
            String? message,
            String? amount,
            String? tier,
            bool? gifted,
            String? sender,
            String? currency,
            bool? isTest)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeActivityDTO():
        return $default(
            _that.id,
            _that.channel,
            _that.username,
            _that.activityType,
            _that.provider,
            _that.message,
            _that.amount,
            _that.tier,
            _that.gifted,
            _that.sender,
            _that.currency,
            _that.isTest);
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
            String channel,
            String username,
            ActivityType activityType,
            StreamProvider provider,
            String? message,
            String? amount,
            String? tier,
            bool? gifted,
            String? sender,
            String? currency,
            bool? isTest)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeActivityDTO() when $default != null:
        return $default(
            _that.id,
            _that.channel,
            _that.username,
            _that.activityType,
            _that.provider,
            _that.message,
            _that.amount,
            _that.tier,
            _that.gifted,
            _that.sender,
            _that.currency,
            _that.isTest);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SeActivityDTO implements SeActivityDTO {
  const _SeActivityDTO(
      {required this.id,
      required this.channel,
      required this.username,
      required this.activityType,
      required this.provider,
      this.message,
      this.amount,
      this.tier,
      this.gifted,
      this.sender,
      this.currency,
      this.isTest});

  @override
  final String id;
  @override
  final String channel;
  @override
  final String username;
  @override
  final ActivityType activityType;
  @override
  final StreamProvider provider;
  @override
  final String? message;
  @override
  final String? amount;
  @override
  final String? tier;
  @override
  final bool? gifted;
  @override
  final String? sender;
  @override
  final String? currency;
  @override
  final bool? isTest;

  /// Create a copy of SeActivityDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeActivityDTOCopyWith<_SeActivityDTO> get copyWith =>
      __$SeActivityDTOCopyWithImpl<_SeActivityDTO>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SeActivityDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.gifted, gifted) || other.gifted == gifted) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.isTest, isTest) || other.isTest == isTest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      channel,
      username,
      activityType,
      provider,
      message,
      amount,
      tier,
      gifted,
      sender,
      currency,
      isTest);

  @override
  String toString() {
    return 'SeActivityDTO(id: $id, channel: $channel, username: $username, activityType: $activityType, provider: $provider, message: $message, amount: $amount, tier: $tier, gifted: $gifted, sender: $sender, currency: $currency, isTest: $isTest)';
  }
}

/// @nodoc
abstract mixin class _$SeActivityDTOCopyWith<$Res>
    implements $SeActivityDTOCopyWith<$Res> {
  factory _$SeActivityDTOCopyWith(
          _SeActivityDTO value, $Res Function(_SeActivityDTO) _then) =
      __$SeActivityDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String channel,
      String username,
      ActivityType activityType,
      StreamProvider provider,
      String? message,
      String? amount,
      String? tier,
      bool? gifted,
      String? sender,
      String? currency,
      bool? isTest});
}

/// @nodoc
class __$SeActivityDTOCopyWithImpl<$Res>
    implements _$SeActivityDTOCopyWith<$Res> {
  __$SeActivityDTOCopyWithImpl(this._self, this._then);

  final _SeActivityDTO _self;
  final $Res Function(_SeActivityDTO) _then;

  /// Create a copy of SeActivityDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? channel = null,
    Object? username = null,
    Object? activityType = null,
    Object? provider = null,
    Object? message = freezed,
    Object? amount = freezed,
    Object? tier = freezed,
    Object? gifted = freezed,
    Object? sender = freezed,
    Object? currency = freezed,
    Object? isTest = freezed,
  }) {
    return _then(_SeActivityDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _self.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as StreamProvider,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
      gifted: freezed == gifted
          ? _self.gifted
          : gifted // ignore: cast_nullable_to_non_nullable
              as bool?,
      sender: freezed == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      isTest: freezed == isTest
          ? _self.isTest
          : isTest // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
