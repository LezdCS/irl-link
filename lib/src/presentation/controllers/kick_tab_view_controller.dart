import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/kick/kick_category.dart';
import 'package:irllink/src/domain/entities/kick/kick_channel.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_categories_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_channels_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/patch_kick_channel_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/views/tabs/rtmp_tab_view.dart';

class KickTabViewController extends GetxController
    with GetTickerProviderStateMixin {
  KickTabViewController({
    required this.patchKickChannelUseCase,
    required this.getKickCategoriesUseCase,
    required this.homeViewController,
    required this.getKickChannelsUseCase,
  });

  final PatchKickChannelUseCase patchKickChannelUseCase;
  final GetKickCategoriesUseCase getKickCategoriesUseCase;
  final HomeViewController homeViewController;
  final GetKickChannelsUseCase getKickChannelsUseCase;

  late TextEditingController titleFormController;
  RxString streamTitle = "".obs;
  RxInt selectedCategoryId = 0.obs;
  Rxn<KickChannel> kickChannel = Rxn<KickChannel>();
  FocusNode focus = FocusNode();

  RxList<KickCategory> kickCategories = <KickCategory>[].obs;

  RxBool displayKickPlayer = false.obs;

  Timer? refreshDataTimer;
  late AnimationController refreshDataAnimationController;
  late AnimationController controllerLiveCircleAnimation;
  late Animation<double> circleShadowAnimation;

  @override
  void onInit() {
    getKickCategories();
    titleFormController = TextEditingController();
    if (!focus.hasFocus) {
      titleFormController.text = "";
    }
    refreshDataAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

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

  void refreshData() async {
    refreshDataAnimationController.reset();
    if (homeViewController.kickData.value == null) {
      return;
    }

    final channelsResult = await getKickChannelsUseCase(
      params: homeViewController.kickData.value!.accessToken,
    );
    channelsResult.fold(
      (l) => {},
      (r) => kickChannel.value = r.first,
    );
    if (!focus.hasFocus) {
      titleFormController.text = kickChannel.value?.streamTitle ?? "";
      selectedCategoryId.value = kickChannel.value?.category.id ?? 0;
    }
    refreshDataAnimationController.forward();
  }

  void getKickCategories() async {
    if (homeViewController.kickData.value == null) {
      return;
    }
    final categories = await getKickCategoriesUseCase(
      params: KickCategoriesParams(
        accessToken: homeViewController.kickData.value!.accessToken,
        searchQuery: "a",
      ),
    );
    categories.fold(
      (failure) => Get.snackbar(
        "Error",
        failure.message,
      ),
      (categories) => {
        kickCategories.value = categories,
      },
    );
  }

  void updateKickChannel() async {
    final categories = await patchKickChannelUseCase(
      params: PatchKickChannelParams(
        accessToken: homeViewController.kickData.value!.accessToken,
        streamTitle: streamTitle.value,
        categoryId: selectedCategoryId.value.toString(),
      ),
    );
    categories.fold(
      (failure) => Get.snackbar(
        "Error",
        failure.message,
      ),
      (categories) => {
        Get.snackbar(
          "Success",
          "Channel updated",
        ),
      },
    );
  }

  void startStreaming() async {
    if (kickChannel.value == null) {
      return;
    }
    // Check if rmptTabViewController is not null in homeViewController
    // If null, we need to init it (might just create a function for that in homeViewController)
    // If not null, we need to call the addTemporaryRtmp function in rtmpTabViewController
    if (homeViewController.rtmpTabViewController == null) {
      homeViewController.initRtmpTabViewController();
    }
    // await for 1 second
    await Future.delayed(const Duration(seconds: 1));
    homeViewController.rtmpTabViewController?.addTemporaryRtmp(
      Rtmp(
        id: 0,
        name: "Kick",
        key: kickChannel.value!.stream.key,
        createdAt: DateTime.now(),
        url: "${kickChannel.value!.stream.url}/app",
      ),
    );
    // find the rtmp tab view in the homeViewController.tabElements
    final rtmpTabView = homeViewController.tabElements
        .firstWhere((element) => element is RtmpTabView);
    // animate to the rtmp tab view
    final indexToGo = homeViewController.tabElements.indexOf(rtmpTabView);
    homeViewController.tabIndex.value = indexToGo;
    homeViewController.tabController.animateTo(indexToGo);
  }
}
