// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_events_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatEventsSettingsDTO _$ChatEventsSettingsDTOFromJson(
    Map<String, dynamic> json) {
  return _ChatEventsSettingsDTO.fromJson(json);
}

/// @nodoc
mixin _$ChatEventsSettingsDTO {
  bool get firstsMessages => throw _privateConstructorUsedError;
  bool get subscriptions => throw _privateConstructorUsedError;
  bool get bitsDonations => throw _privateConstructorUsedError;
  bool get announcements => throw _privateConstructorUsedError;
  bool get incomingRaids => throw _privateConstructorUsedError;
  bool get redemptions => throw _privateConstructorUsedError;

  /// Serializes this ChatEventsSettingsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatEventsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatEventsSettingsDTOCopyWith<ChatEventsSettingsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventsSettingsDTOCopyWith<$Res> {
  factory $ChatEventsSettingsDTOCopyWith(ChatEventsSettingsDTO value,
          $Res Function(ChatEventsSettingsDTO) then) =
      _$ChatEventsSettingsDTOCopyWithImpl<$Res, ChatEventsSettingsDTO>;
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
class _$ChatEventsSettingsDTOCopyWithImpl<$Res,
        $Val extends ChatEventsSettingsDTO>
    implements $ChatEventsSettingsDTOCopyWith<$Res> {
  _$ChatEventsSettingsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      firstsMessages: null == firstsMessages
          ? _value.firstsMessages
          : firstsMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptions: null == subscriptions
          ? _value.subscriptions
          : subscriptions // ignore: cast_nullable_to_non_nullable
              as bool,
      bitsDonations: null == bitsDonations
          ? _value.bitsDonations
          : bitsDonations // ignore: cast_nullable_to_non_nullable
              as bool,
      announcements: null == announcements
          ? _value.announcements
          : announcements // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingRaids: null == incomingRaids
          ? _value.incomingRaids
          : incomingRaids // ignore: cast_nullable_to_non_nullable
              as bool,
      redemptions: null == redemptions
          ? _value.redemptions
          : redemptions // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatEventsSettingsDTOImplCopyWith<$Res>
    implements $ChatEventsSettingsDTOCopyWith<$Res> {
  factory _$$ChatEventsSettingsDTOImplCopyWith(
          _$ChatEventsSettingsDTOImpl value,
          $Res Function(_$ChatEventsSettingsDTOImpl) then) =
      __$$ChatEventsSettingsDTOImplCopyWithImpl<$Res>;
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
class __$$ChatEventsSettingsDTOImplCopyWithImpl<$Res>
    extends _$ChatEventsSettingsDTOCopyWithImpl<$Res,
        _$ChatEventsSettingsDTOImpl>
    implements _$$ChatEventsSettingsDTOImplCopyWith<$Res> {
  __$$ChatEventsSettingsDTOImplCopyWithImpl(_$ChatEventsSettingsDTOImpl _value,
      $Res Function(_$ChatEventsSettingsDTOImpl) _then)
      : super(_value, _then);

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
    return _then(_$ChatEventsSettingsDTOImpl(
      firstsMessages: null == firstsMessages
          ? _value.firstsMessages
          : firstsMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptions: null == subscriptions
          ? _value.subscriptions
          : subscriptions // ignore: cast_nullable_to_non_nullable
              as bool,
      bitsDonations: null == bitsDonations
          ? _value.bitsDonations
          : bitsDonations // ignore: cast_nullable_to_non_nullable
              as bool,
      announcements: null == announcements
          ? _value.announcements
          : announcements // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingRaids: null == incomingRaids
          ? _value.incomingRaids
          : incomingRaids // ignore: cast_nullable_to_non_nullable
              as bool,
      redemptions: null == redemptions
          ? _value.redemptions
          : redemptions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatEventsSettingsDTOImpl extends _ChatEventsSettingsDTO {
  _$ChatEventsSettingsDTOImpl(
      {this.firstsMessages = true,
      this.subscriptions = true,
      this.bitsDonations = true,
      this.announcements = true,
      this.incomingRaids = true,
      this.redemptions = true})
      : super._();

  factory _$ChatEventsSettingsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatEventsSettingsDTOImplFromJson(json);

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

  @override
  String toString() {
    return 'ChatEventsSettingsDTO(firstsMessages: $firstsMessages, subscriptions: $subscriptions, bitsDonations: $bitsDonations, announcements: $announcements, incomingRaids: $incomingRaids, redemptions: $redemptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatEventsSettingsDTOImpl &&
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

  /// Create a copy of ChatEventsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatEventsSettingsDTOImplCopyWith<_$ChatEventsSettingsDTOImpl>
      get copyWith => __$$ChatEventsSettingsDTOImplCopyWithImpl<
          _$ChatEventsSettingsDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatEventsSettingsDTOImplToJson(
      this,
    );
  }
}

abstract class _ChatEventsSettingsDTO extends ChatEventsSettingsDTO {
  factory _ChatEventsSettingsDTO(
      {final bool firstsMessages,
      final bool subscriptions,
      final bool bitsDonations,
      final bool announcements,
      final bool incomingRaids,
      final bool redemptions}) = _$ChatEventsSettingsDTOImpl;
  _ChatEventsSettingsDTO._() : super._();

  factory _ChatEventsSettingsDTO.fromJson(Map<String, dynamic> json) =
      _$ChatEventsSettingsDTOImpl.fromJson;

  @override
  bool get firstsMessages;
  @override
  bool get subscriptions;
  @override
  bool get bitsDonations;
  @override
  bool get announcements;
  @override
  bool get incomingRaids;
  @override
  bool get redemptions;

  /// Create a copy of ChatEventsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatEventsSettingsDTOImplCopyWith<_$ChatEventsSettingsDTOImpl>
      get copyWith => throw _privateConstructorUsedError;
}
