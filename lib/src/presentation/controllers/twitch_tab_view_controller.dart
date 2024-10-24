import 'dart:async';

import 'package:flutter/services.dart';
import 'package:irllink/src/core/resources/data_state.dart';

import 'home_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

class TwitchTabViewController extends GetxController
    with GetTickerProviderStateMixin {
  TwitchTabViewController({required this.homeEvents});

  final HomeViewController homeViewController = Get.find<HomeViewController>();

  final HomeEvents homeEvents;

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

  @override
  void onInit() {
    titleFormController = TextEditingController();

    twitchStreamInfos.listen((value) {
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendViewersToNative",
        "data": value.viewerCount,
      });
      platform.invokeMethod("flutterToWatch", {
        "method": "sendLiveStatusToNative",
        "data": value.isOnline,
      });
    });

    controllerLiveCircleAnimation = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    circleShadowAnimation = Tween<double>(begin: 3.0, end: 20.0).animate(
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
    DataState<TwitchStreamInfos> streamInfos = await homeEvents.getStreamInfo(
      homeViewController.twitchData!.accessToken,
      homeViewController.twitchData!.twitchUser.id,
    );
    if (streamInfos is DataSuccess) {
      twitchStreamInfos.value = streamInfos.data!;
    }
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
    homeEvents.setChatSettings(
      homeViewController.twitchData!.accessToken,
      homeViewController.twitchData!.twitchUser.id,
      twitchStreamInfos.value,
    );
  }

  void setStreamTitle() {
    homeEvents.setStreamTitle(
      homeViewController.twitchData!.accessToken,
      homeViewController.twitchData!.twitchUser.id,
      titleFormController.text,
    );
  }
}
