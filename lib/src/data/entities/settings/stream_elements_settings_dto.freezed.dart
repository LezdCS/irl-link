// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stream_elements_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreamElementsSettingsDTO {
  bool get showFollowerActivity;
  bool get showSubscriberActivity;
  bool get showDonationActivity;
  bool get showCheerActivity;
  bool get showRaidActivity;
  bool get showHostActivity;
  bool get showMerchActivity;
  String? get jwt;
  String? get overlayToken;
  List<String> get mutedOverlays;

  /// Create a copy of StreamElementsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StreamElementsSettingsDTOCopyWith<StreamElementsSettingsDTO> get copyWith =>
      _$StreamElementsSettingsDTOCopyWithImpl<StreamElementsSettingsDTO>(
          this as StreamElementsSettingsDTO, _$identity);

  /// Serializes this StreamElementsSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StreamElementsSettingsDTO &&
            (identical(other.showFollowerActivity, showFollowerActivity) ||
                other.showFollowerActivity == showFollowerActivity) &&
            (identical(other.showSubscriberActivity, showSubscriberActivity) ||
                other.showSubscriberActivity == showSubscriberActivity) &&
            (identical(other.showDonationActivity, showDonationActivity) ||
                other.showDonationActivity == showDonationActivity) &&
            (identical(other.showCheerActivity, showCheerActivity) ||
                other.showCheerActivity == showCheerActivity) &&
            (identical(other.showRaidActivity, showRaidActivity) ||
                other.showRaidActivity == showRaidActivity) &&
            (identical(other.showHostActivity, showHostActivity) ||
                other.showHostActivity == showHostActivity) &&
            (identical(other.showMerchActivity, showMerchActivity) ||
                other.showMerchActivity == showMerchActivity) &&
            (identical(other.jwt, jwt) || other.jwt == jwt) &&
            (identical(other.overlayToken, overlayToken) ||
                other.overlayToken == overlayToken) &&
            const DeepCollectionEquality()
                .equals(other.mutedOverlays, mutedOverlays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      showFollowerActivity,
      showSubscriberActivity,
      showDonationActivity,
      showCheerActivity,
      showRaidActivity,
      showHostActivity,
      showMerchActivity,
      jwt,
      overlayToken,
      const DeepCollectionEquality().hash(mutedOverlays));

  @override
  String toString() {
    return 'StreamElementsSettingsDTO(showFollowerActivity: $showFollowerActivity, showSubscriberActivity: $showSubscriberActivity, showDonationActivity: $showDonationActivity, showCheerActivity: $showCheerActivity, showRaidActivity: $showRaidActivity, showHostActivity: $showHostActivity, showMerchActivity: $showMerchActivity, jwt: $jwt, overlayToken: $overlayToken, mutedOverlays: $mutedOverlays)';
  }
}

/// @nodoc
abstract mixin class $StreamElementsSettingsDTOCopyWith<$Res> {
  factory $StreamElementsSettingsDTOCopyWith(StreamElementsSettingsDTO value,
          $Res Function(StreamElementsSettingsDTO) _then) =
      _$StreamElementsSettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {bool showFollowerActivity,
      bool showSubscriberActivity,
      bool showDonationActivity,
      bool showCheerActivity,
      bool showRaidActivity,
      bool showHostActivity,
      bool showMerchActivity,
      String? jwt,
      String? overlayToken,
      List<String> mutedOverlays});
}

/// @nodoc
class _$StreamElementsSettingsDTOCopyWithImpl<$Res>
    implements $StreamElementsSettingsDTOCopyWith<$Res> {
  _$StreamElementsSettingsDTOCopyWithImpl(this._self, this._then);

  final StreamElementsSettingsDTO _self;
  final $Res Function(StreamElementsSettingsDTO) _then;

  /// Create a copy of StreamElementsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showFollowerActivity = null,
    Object? showSubscriberActivity = null,
    Object? showDonationActivity = null,
    Object? showCheerActivity = null,
    Object? showRaidActivity = null,
    Object? showHostActivity = null,
    Object? showMerchActivity = null,
    Object? jwt = freezed,
    Object? overlayToken = freezed,
    Object? mutedOverlays = null,
  }) {
    return _then(_self.copyWith(
      showFollowerActivity: null == showFollowerActivity
          ? _self.showFollowerActivity
          : showFollowerActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showSubscriberActivity: null == showSubscriberActivity
          ? _self.showSubscriberActivity
          : showSubscriberActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showDonationActivity: null == showDonationActivity
          ? _self.showDonationActivity
          : showDonationActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showCheerActivity: null == showCheerActivity
          ? _self.showCheerActivity
          : showCheerActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showRaidActivity: null == showRaidActivity
          ? _self.showRaidActivity
          : showRaidActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showHostActivity: null == showHostActivity
          ? _self.showHostActivity
          : showHostActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showMerchActivity: null == showMerchActivity
          ? _self.showMerchActivity
          : showMerchActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      jwt: freezed == jwt
          ? _self.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String?,
      overlayToken: freezed == overlayToken
          ? _self.overlayToken
          : overlayToken // ignore: cast_nullable_to_non_nullable
              as String?,
      mutedOverlays: null == mutedOverlays
          ? _self.mutedOverlays
          : mutedOverlays // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StreamElementsSettingsDTO implements StreamElementsSettingsDTO {
  const _StreamElementsSettingsDTO(
      {this.showFollowerActivity = true,
      this.showSubscriberActivity = true,
      this.showDonationActivity = true,
      this.showCheerActivity = true,
      this.showRaidActivity = true,
      this.showHostActivity = true,
      this.showMerchActivity = true,
      required this.jwt,
      required this.overlayToken,
      final List<String> mutedOverlays = const []})
      : _mutedOverlays = mutedOverlays;
  factory _StreamElementsSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$StreamElementsSettingsDTOFromJson(json);

  @override
  @JsonKey()
  final bool showFollowerActivity;
  @override
  @JsonKey()
  final bool showSubscriberActivity;
  @override
  @JsonKey()
  final bool showDonationActivity;
  @override
  @JsonKey()
  final bool showCheerActivity;
  @override
  @JsonKey()
  final bool showRaidActivity;
  @override
  @JsonKey()
  final bool showHostActivity;
  @override
  @JsonKey()
  final bool showMerchActivity;
  @override
  final String? jwt;
  @override
  final String? overlayToken;
  final List<String> _mutedOverlays;
  @override
  @JsonKey()
  List<String> get mutedOverlays {
    if (_mutedOverlays is EqualUnmodifiableListView) return _mutedOverlays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mutedOverlays);
  }

  /// Create a copy of StreamElementsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StreamElementsSettingsDTOCopyWith<_StreamElementsSettingsDTO>
      get copyWith =>
          __$StreamElementsSettingsDTOCopyWithImpl<_StreamElementsSettingsDTO>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StreamElementsSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StreamElementsSettingsDTO &&
            (identical(other.showFollowerActivity, showFollowerActivity) ||
                other.showFollowerActivity == showFollowerActivity) &&
            (identical(other.showSubscriberActivity, showSubscriberActivity) ||
                other.showSubscriberActivity == showSubscriberActivity) &&
            (identical(other.showDonationActivity, showDonationActivity) ||
                other.showDonationActivity == showDonationActivity) &&
            (identical(other.showCheerActivity, showCheerActivity) ||
                other.showCheerActivity == showCheerActivity) &&
            (identical(other.showRaidActivity, showRaidActivity) ||
                other.showRaidActivity == showRaidActivity) &&
            (identical(other.showHostActivity, showHostActivity) ||
                other.showHostActivity == showHostActivity) &&
            (identical(other.showMerchActivity, showMerchActivity) ||
                other.showMerchActivity == showMerchActivity) &&
            (identical(other.jwt, jwt) || other.jwt == jwt) &&
            (identical(other.overlayToken, overlayToken) ||
                other.overlayToken == overlayToken) &&
            const DeepCollectionEquality()
                .equals(other._mutedOverlays, _mutedOverlays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      showFollowerActivity,
      showSubscriberActivity,
      showDonationActivity,
      showCheerActivity,
      showRaidActivity,
      showHostActivity,
      showMerchActivity,
      jwt,
      overlayToken,
      const DeepCollectionEquality().hash(_mutedOverlays));

  @override
  String toString() {
    return 'StreamElementsSettingsDTO(showFollowerActivity: $showFollowerActivity, showSubscriberActivity: $showSubscriberActivity, showDonationActivity: $showDonationActivity, showCheerActivity: $showCheerActivity, showRaidActivity: $showRaidActivity, showHostActivity: $showHostActivity, showMerchActivity: $showMerchActivity, jwt: $jwt, overlayToken: $overlayToken, mutedOverlays: $mutedOverlays)';
  }
}

/// @nodoc
abstract mixin class _$StreamElementsSettingsDTOCopyWith<$Res>
    implements $StreamElementsSettingsDTOCopyWith<$Res> {
  factory _$StreamElementsSettingsDTOCopyWith(_StreamElementsSettingsDTO value,
          $Res Function(_StreamElementsSettingsDTO) _then) =
      __$StreamElementsSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool showFollowerActivity,
      bool showSubscriberActivity,
      bool showDonationActivity,
      bool showCheerActivity,
      bool showRaidActivity,
      bool showHostActivity,
      bool showMerchActivity,
      String? jwt,
      String? overlayToken,
      List<String> mutedOverlays});
}

/// @nodoc
class __$StreamElementsSettingsDTOCopyWithImpl<$Res>
    implements _$StreamElementsSettingsDTOCopyWith<$Res> {
  __$StreamElementsSettingsDTOCopyWithImpl(this._self, this._then);

  final _StreamElementsSettingsDTO _self;
  final $Res Function(_StreamElementsSettingsDTO) _then;

  /// Create a copy of StreamElementsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? showFollowerActivity = null,
    Object? showSubscriberActivity = null,
    Object? showDonationActivity = null,
    Object? showCheerActivity = null,
    Object? showRaidActivity = null,
    Object? showHostActivity = null,
    Object? showMerchActivity = null,
    Object? jwt = freezed,
    Object? overlayToken = freezed,
    Object? mutedOverlays = null,
  }) {
    return _then(_StreamElementsSettingsDTO(
      showFollowerActivity: null == showFollowerActivity
          ? _self.showFollowerActivity
          : showFollowerActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showSubscriberActivity: null == showSubscriberActivity
          ? _self.showSubscriberActivity
          : showSubscriberActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showDonationActivity: null == showDonationActivity
          ? _self.showDonationActivity
          : showDonationActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showCheerActivity: null == showCheerActivity
          ? _self.showCheerActivity
          : showCheerActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showRaidActivity: null == showRaidActivity
          ? _self.showRaidActivity
          : showRaidActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showHostActivity: null == showHostActivity
          ? _self.showHostActivity
          : showHostActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      showMerchActivity: null == showMerchActivity
          ? _self.showMerchActivity
          : showMerchActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      jwt: freezed == jwt
          ? _self.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String?,
      overlayToken: freezed == overlayToken
          ? _self.overlayToken
          : overlayToken // ignore: cast_nullable_to_non_nullable
              as String?,
      mutedOverlays: null == mutedOverlays
          ? _self._mutedOverlays
          : mutedOverlays // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
