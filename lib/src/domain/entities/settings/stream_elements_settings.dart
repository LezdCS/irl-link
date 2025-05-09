import 'package:flutter/material.dart';

@immutable
class StreamElementsSettings {
  final bool showFollowerActivity;
  final bool showSubscriberActivity;
  final bool showDonationActivity;
  final bool showCheerActivity;
  final bool showRaidActivity;
  final bool showHostActivity;
  final bool showMerchActivity;
  final String? jwt;
  final String? overlayToken;
  final List<String> mutedOverlays;

  const StreamElementsSettings({
    required this.showFollowerActivity,
    required this.showSubscriberActivity,
    required this.showDonationActivity,
    required this.showCheerActivity,
    required this.showRaidActivity,
    required this.showHostActivity,
    required this.showMerchActivity,
    required this.jwt,
    required this.overlayToken,
    required this.mutedOverlays,
  });

  StreamElementsSettings copyWith({
    bool? showFollowerActivity,
    bool? showSubscriberActivity,
    bool? showDonationActivity,
    bool? showCheerActivity,
    bool? showRaidActivity,
    bool? showHostActivity,
    bool? showMerchActivity,
    String? jwt,
    String? overlayToken,
    List<String>? mutedOverlays,
  }) {
    return StreamElementsSettings(
      showFollowerActivity: showFollowerActivity ?? this.showFollowerActivity,
      showSubscriberActivity:
          showSubscriberActivity ?? this.showSubscriberActivity,
      showDonationActivity: showDonationActivity ?? this.showDonationActivity,
      showCheerActivity: showCheerActivity ?? this.showCheerActivity,
      showRaidActivity: showRaidActivity ?? this.showRaidActivity,
      showHostActivity: showHostActivity ?? this.showHostActivity,
      showMerchActivity: showMerchActivity ?? this.showMerchActivity,
      jwt: jwt ?? this.jwt,
      overlayToken: overlayToken ?? this.overlayToken,
      mutedOverlays: mutedOverlays ?? this.mutedOverlays,
    );
  }
}
