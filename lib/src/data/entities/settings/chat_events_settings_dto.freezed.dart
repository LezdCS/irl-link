// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_events_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatEventsSettingsDTO {
  bool get firstsMessages;
  bool get subscriptions;
  bool get bitsDonations;
  bool get announcements;
  bool get incomingRaids;
  bool get redemptions;

  /// Create a copy of ChatEventsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatEventsSettingsDTOCopyWith<ChatEventsSettingsDTO> get copyWith =>
      _$ChatEventsSettingsDTOCopyWithImpl<ChatEventsSettingsDTO>(
          this as ChatEventsSettingsDTO, _$identity);

  /// Serializes this ChatEventsSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatEventsSettingsDTO &&
            (identical(other.firstsMessages, firstsMessages) ||
                other.firstsMessages == firstsMessages) &&
            (identical(other.subscriptions, subscriptions) ||
                other.subscriptions == subscriptions) &&
            (identical(other.bitsDonations, bitsDonations) ||
                other.bitsDonations == bitsDonations) &&
            (identical(other.announcements, announcements) ||
                other.announcements == announcements) &&
            (identical(other.incomingRaids, incomingRaids) ||
                other.incomingRaids == incomingRaids) &&
            (identical(other.redemptions, redemptions) ||
                other.redemptions == redemptions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstsMessages, subscriptions,
      bitsDonations, announcements, incomingRaids, redemptions);

  @override
  String toString() {
    return 'ChatEventsSettingsDTO(firstsMessages: $firstsMessages, subscriptions: $subscriptions, bitsDonations: $bitsDonations, announcements: $announcements, incomingRaids: $incomingRaids, redemptions: $redemptions)';
  }
}

/// @nodoc
abstract mixin class $ChatEventsSettingsDTOCopyWith<$Res> {
  factory $ChatEventsSettingsDTOCopyWith(ChatEventsSettingsDTO value,
          $Res Function(ChatEventsSettingsDTO) _then) =
      _$ChatEventsSettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {bool firstsMessages,
      bool subscriptions,
      bool bitsDonations,
      bool announcements,
      bool incomingRaids,
      bool redemptions});
}

/// @nodoc
class _$ChatEventsSettingsDTOCopyWithImpl<$Res>
    implements $ChatEventsSettingsDTOCopyWith<$Res> {
  _$ChatEventsSettingsDTOCopyWithImpl(this._self, this._then);

  final ChatEventsSettingsDTO _self;
  final $Res Function(ChatEventsSettingsDTO) _then;

  /// Create a copy of ChatEventsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstsMessages = null,
    Object? subscriptions = null,
    Object? bitsDonations = null,
    Object? announcements = null,
    Object? incomingRaids = null,
    Object? redemptions = null,
  }) {
    return _then(_self.copyWith(
      firstsMessages: null == firstsMessages
          ? _self.firstsMessages
          : firstsMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptions: null == subscriptions
          ? _self.subscriptions
          : subscriptions // ignore: cast_nullable_to_non_nullable
              as bool,
      bitsDonations: null == bitsDonations
          ? _self.bitsDonations
          : bitsDonations // ignore: cast_nullable_to_non_nullable
              as bool,
      announcements: null == announcements
          ? _self.announcements
          : announcements // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingRaids: null == incomingRaids
          ? _self.incomingRaids
          : incomingRaids // ignore: cast_nullable_to_non_nullable
              as bool,
      redemptions: null == redemptions
          ? _self.redemptions
          : redemptions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChatEventsSettingsDTO].
extension ChatEventsSettingsDTOPatterns on ChatEventsSettingsDTO {
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
    TResult Function(_ChatEventsSettingsDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatEventsSettingsDTO() when $default != null:
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
    TResult Function(_ChatEventsSettingsDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatEventsSettingsDTO():
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
    TResult? Function(_ChatEventsSettingsDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatEventsSettingsDTO() when $default != null:
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
            bool firstsMessages,
            bool subscriptions,
            bool bitsDonations,
            bool announcements,
            bool incomingRaids,
            bool redemptions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatEventsSettingsDTO() when $default != null:
        return $default(
            _that.firstsMessages,
            _that.subscriptions,
            _that.bitsDonations,
            _that.announcements,
            _that.incomingRaids,
            _that.redemptions);
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
            bool firstsMessages,
            bool subscriptions,
            bool bitsDonations,
            bool announcements,
            bool incomingRaids,
            bool redemptions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatEventsSettingsDTO():
        return $default(
            _that.firstsMessages,
            _that.subscriptions,
            _that.bitsDonations,
            _that.announcements,
            _that.incomingRaids,
            _that.redemptions);
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
            bool firstsMessages,
            bool subscriptions,
            bool bitsDonations,
            bool announcements,
            bool incomingRaids,
            bool redemptions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatEventsSettingsDTO() when $default != null:
        return $default(
            _that.firstsMessages,
            _that.subscriptions,
            _that.bitsDonations,
            _that.announcements,
            _that.incomingRaids,
            _that.redemptions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChatEventsSettingsDTO extends ChatEventsSettingsDTO {
  _ChatEventsSettingsDTO(
      {this.firstsMessages = true,
      this.subscriptions = true,
      this.bitsDonations = true,
      this.announcements = true,
      this.incomingRaids = true,
      this.redemptions = true})
      : super._();
  factory _ChatEventsSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatEventsSettingsDTOFromJson(json);

  @override
  @JsonKey()
  final bool firstsMessages;
  @override
  @JsonKey()
  final bool subscriptions;
  @override
  @JsonKey()
  final bool bitsDonations;
  @override
  @JsonKey()
  final bool announcements;
  @override
  @JsonKey()
  final bool incomingRaids;
  @override
  @JsonKey()
  final bool redemptions;

  /// Create a copy of ChatEventsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatEventsSettingsDTOCopyWith<_ChatEventsSettingsDTO> get copyWith =>
      __$ChatEventsSettingsDTOCopyWithImpl<_ChatEventsSettingsDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatEventsSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatEventsSettingsDTO &&
            (identical(other.firstsMessages, firstsMessages) ||
                other.firstsMessages == firstsMessages) &&
            (identical(other.subscriptions, subscriptions) ||
                other.subscriptions == subscriptions) &&
            (identical(other.bitsDonations, bitsDonations) ||
                other.bitsDonations == bitsDonations) &&
            (identical(other.announcements, announcements) ||
                other.announcements == announcements) &&
            (identical(other.incomingRaids, incomingRaids) ||
                other.incomingRaids == incomingRaids) &&
            (identical(other.redemptions, redemptions) ||
                other.redemptions == redemptions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstsMessages, subscriptions,
      bitsDonations, announcements, incomingRaids, redemptions);

  @override
  String toString() {
    return 'ChatEventsSettingsDTO(firstsMessages: $firstsMessages, subscriptions: $subscriptions, bitsDonations: $bitsDonations, announcements: $announcements, incomingRaids: $incomingRaids, redemptions: $redemptions)';
  }
}

/// @nodoc
abstract mixin class _$ChatEventsSettingsDTOCopyWith<$Res>
    implements $ChatEventsSettingsDTOCopyWith<$Res> {
  factory _$ChatEventsSettingsDTOCopyWith(_ChatEventsSettingsDTO value,
          $Res Function(_ChatEventsSettingsDTO) _then) =
      __$ChatEventsSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool firstsMessages,
      bool subscriptions,
      bool bitsDonations,
      bool announcements,
      bool incomingRaids,
      bool redemptions});
}

/// @nodoc
class __$ChatEventsSettingsDTOCopyWithImpl<$Res>
    implements _$ChatEventsSettingsDTOCopyWith<$Res> {
  __$ChatEventsSettingsDTOCopyWithImpl(this._self, this._then);

  final _ChatEventsSettingsDTO _self;
  final $Res Function(_ChatEventsSettingsDTO) _then;

  /// Create a copy of ChatEventsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? firstsMessages = null,
    Object? subscriptions = null,
    Object? bitsDonations = null,
    Object? announcements = null,
    Object? incomingRaids = null,
    Object? redemptions = null,
  }) {
    return _then(_ChatEventsSettingsDTO(
      firstsMessages: null == firstsMessages
          ? _self.firstsMessages
          : firstsMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptions: null == subscriptions
          ? _self.subscriptions
          : subscriptions // ignore: cast_nullable_to_non_nullable
              as bool,
      bitsDonations: null == bitsDonations
          ? _self.bitsDonations
          : bitsDonations // ignore: cast_nullable_to_non_nullable
              as bool,
      announcements: null == announcements
          ? _self.announcements
          : announcements // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingRaids: null == incomingRaids
          ? _self.incomingRaids
          : incomingRaids // ignore: cast_nullable_to_non_nullable
              as bool,
      redemptions: null == redemptions
          ? _self.redemptions
          : redemptions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
