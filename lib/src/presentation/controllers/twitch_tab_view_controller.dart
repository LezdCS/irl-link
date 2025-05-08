import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/usecases/twitch/get_stream_info_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/set_chat_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/set_stream_title_usecase.dart';

class TwitchTabViewController extends GetxController
    with GetTickerProviderStateMixin {
  TwitchTabViewController({
    required this.getStreamInfoUseCase,
    required this.setChatSettingsUseCase,
    required this.setStreamTitleUseCase,
    required this.watchService,
  });

  final GetStreamInfoUseCase getStreamInfoUseCase;
  final SetChatSettingsUseCase setChatSettingsUseCase;
  final SetStreamTitleUseCase setStreamTitleUseCase;
  final WatchService watchService;

  late TextEditingController titleFormController;
  RxString streamTitle = "".obs;

  FocusNode focus = FocusNode();

  Rx<TwitchStreamInfos> twitchStreamInfos =
      const TwitchStreamInfos.defaultInfos().obs;
  late AnimationController controllerLiveCircleAnimation;
  late Animation<double> circleShadowAnimation;

  Timer? refreshDataTimer;
  late AnimationController refreshDataAnimationController;

  RxBool displayTwitchPlayer = false.obs;

  // Store the necessary Twitch data
  String? accessToken;
  String? broadcasterId;

  void setup({
    required String token,
    required String broadcasterId,
  }) {
    accessToken = token;
    this.broadcasterId = broadcasterId;
  }

  @override
  void onInit() {
    titleFormController = TextEditingController();

    twitchStreamInfos.listen((value) {
      // Send to watchOS
      watchService.sendViewersToNative(value.viewerCount ?? 0);
      watchService.sendLiveStatusToNative(isLive: value.isOnline ?? false);
    });

    controllerLiveCircleAnimation = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    circleShadowAnimation = Tween<double>(begin: 3, end: 20).animate(
      CurvedAnimation(
        parent: controllerLiveCircleAnimation,
        curve: Curves.easeInOut,
      ),
    );

    refreshDataAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

    super.onInit();
  }

  @override
  void onReady() async {
    refreshData();
    refreshDataTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      refreshData();
    });

    super.onReady();
  }

  @override
  void onClose() {
    controllerLiveCircleAnimation.dispose();
    refreshDataAnimationController.dispose();
    refreshDataTimer?.cancel();
    super.onClose();
  }

  Future<void> refreshData() async {
    refreshDataAnimationController.reset();
    if (accessToken == null || broadcasterId == null) {
      return;
    }

    final streamInfosResult = await getStreamInfoUseCase(
      params: GetStreamInfoUseCaseParams(
        accessToken: accessToken!,
        broadcasterId: broadcasterId!,
      ),
    );
    streamInfosResult.fold(
      (l) => {},
      (r) => twitchStreamInfos.value = r,
    );
    if (!focus.hasFocus) {
      titleFormController.text = twitchStreamInfos.value.title!;
    }
    refreshDataAnimationController.forward();
  }

  void toggleFollowerOnly() {
    twitchStreamInfos.value = twitchStreamInfos.value
        .copyWith(isFollowerMode: !twitchStreamInfos.value.isFollowerMode!);
    changeChatSettings();
  }

  void toggleSubOnly() {
    twitchStreamInfos.value = twitchStreamInfos.value
        .copyWith(isSubscriberMode: !twitchStreamInfos.value.isSubscriberMode!);
    changeChatSettings();
  }

  void toggleEmoteOnly() {
    twitchStreamInfos.value = twitchStreamInfos.value
        .copyWith(isEmoteMode: !twitchStreamInfos.value.isEmoteMode!);
    changeChatSettings();
  }

  void toggleSlowMode(int? time) {
    twitchStreamInfos.value = twitchStreamInfos.value.copyWith(
      isSlowMode: !twitchStreamInfos.value.isSlowMode!,
      slowModeWaitTime: time,
    );
    changeChatSettings();
  }

  void changeChatSettings() {
    if (accessToken == null || broadcasterId == null) {
      return;
    }

    setChatSettingsUseCase(
      params: SetChatSettingsUseCaseParams(
        accessToken: accessToken!,
        broadcasterId: broadcasterId!,
        twitchStreamInfos: twitchStreamInfos.value,
      ),
    );
  }

  void setStreamTitle() {
    if (accessToken == null || broadcasterId == null) {
      return;
    }

    setStreamTitleUseCase(
      params: SetStreamTitleUseCaseParams(
        accessToken: accessToken!,
        broadcasterId: broadcasterId!,
        title: titleFormController.text,
      ),
    );
  }
}
