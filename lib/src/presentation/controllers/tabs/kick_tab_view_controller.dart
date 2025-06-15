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
import 'package:irllink/src/presentation/controllers/tabs_controller.dart';
import 'package:irllink/src/presentation/views/tabs/rtmp_tab_view.dart';

class KickTabViewController extends GetxController
    with GetTickerProviderStateMixin {
  KickTabViewController({
    required this.patchKickChannelUseCase,
    required this.getKickCategoriesUseCase,
    required this.getKickChannelsUseCase,
  });

  final PatchKickChannelUseCase patchKickChannelUseCase;
  final GetKickCategoriesUseCase getKickCategoriesUseCase;
  final GetKickChannelsUseCase getKickChannelsUseCase;

  late TextEditingController categoryFormController;
  late TextEditingController titleFormController;
  RxString streamTitle = "".obs;
  RxInt selectedCategoryId = 0.obs;
  Rxn<KickChannel> kickChannel = Rxn<KickChannel>();
  FocusNode focus = FocusNode();

  RxList<KickCategory> kickCategories = <KickCategory>[].obs;
  RxString categorySearchQuery = "".obs;

  RxBool displayKickPlayer = false.obs;

  Timer? refreshDataTimer;
  late AnimationController refreshDataAnimationController;
  late AnimationController controllerLiveCircleAnimation;
  late Animation<double> circleShadowAnimation;

  void onCategorySearchChanged(String value) {
    categorySearchQuery.value = value;
    getKickCategories();
  }

  @override
  void onInit() {
    titleFormController = TextEditingController();
    categoryFormController = TextEditingController();
    if (!focus.hasFocus) {
      titleFormController.text = "";
      categoryFormController.text = "";
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
    await refreshData();

    await getKickCategories();

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
    if (Get.find<HomeViewController>().kickData.value == null) {
      return;
    }

    final channelsResult = await getKickChannelsUseCase(
      params: Get.find<HomeViewController>().kickData.value!.accessToken,
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

  Future<void> getKickCategories() async {
    if (Get.find<HomeViewController>().kickData.value == null) {
      return;
    }
    final categories = await getKickCategoriesUseCase(
      params: KickCategoriesParams(
        accessToken: Get.find<HomeViewController>().kickData.value!.accessToken,
        searchQuery:
            categorySearchQuery.value.isEmpty ? "a" : categorySearchQuery.value,
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
    final resultUpdate = await patchKickChannelUseCase(
      params: PatchKickChannelParams(
        accessToken: Get.find<HomeViewController>().kickData.value!.accessToken,
        streamTitle: streamTitle.value,
        categoryId: selectedCategoryId.value.toString(),
      ),
    );
    resultUpdate.fold(
      (l) => Get.snackbar(
        "Error",
        l.message,
      ),
      (r) => {
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
    if (Get.find<TabsController>().rtmpTabViewController == null) {
      Get.find<TabsController>().initRtmpTabViewController();
    }
    await Future.delayed(const Duration(seconds: 1));
    Get.find<TabsController>().rtmpTabViewController?.addTemporaryRtmp(
          Rtmp(
            id: 0,
            name: "Kick",
            key: kickChannel.value!.stream.key,
            createdAt: DateTime.now(),
            url: "${kickChannel.value!.stream.url}/app",
          ),
        );
    // find the rtmp tab view in the homeViewController.tabElements
    final rtmpTabView = Get.find<TabsController>()
        .tabElements
        .firstWhere((element) => element is RtmpTabView);
    // animate to the rtmp tab view
    final indexToGo =
        Get.find<TabsController>().tabElements.indexOf(rtmpTabView);
    Get.find<TabsController>().setTabIndex(indexToGo);
  }
}
