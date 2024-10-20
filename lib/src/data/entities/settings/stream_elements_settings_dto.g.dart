// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_elements_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreamElementsSettingsDTOImpl _$$StreamElementsSettingsDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$StreamElementsSettingsDTOImpl(
      showFollowerActivity: json['showFollowerActivity'] as bool? ?? true,
      showSubscriberActivity: json['showSubscriberActivity'] as bool? ?? true,
      showDonationActivity: json['showDonationActivity'] as bool? ?? true,
      showCheerActivity: json['showCheerActivity'] as bool? ?? true,
      showRaidActivity: json['showRaidActivity'] as bool? ?? true,
      showHostActivity: json['showHostActivity'] as bool? ?? true,
      showMerchActivity: json['showMerchActivity'] as bool? ?? true,
      jwt: json['jwt'] as String?,
      overlayToken: json['overlayToken'] as String?,
      mutedOverlays: (json['mutedOverlays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StreamElementsSettingsDTOImplToJson(
        _$StreamElementsSettingsDTOImpl instance) =>
    <String, dynamic>{
      'showFollowerActivity': instance.showFollowerActivity,
      'showSubscriberActivity': instance.showSubscriberActivity,
      'showDonationActivity': instance.showDonationActivity,
      'showCheerActivity': instance.showCheerActivity,
      'showRaidActivity': instance.showRaidActivity,
      'showHostActivity': instance.showHostActivity,
      'showMerchActivity': instance.showMerchActivity,
      'jwt': instance.jwt,
      'overlayToken': instance.overlayToken,
      'mutedOverlays': instance.mutedOverlays,
    };
