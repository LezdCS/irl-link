// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
