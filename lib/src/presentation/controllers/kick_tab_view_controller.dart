import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/kick/kick_category.dart';
import 'package:irllink/src/domain/entities/kick/kick_channel.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_categories_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_channels_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/patch_kick_channel_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

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
  Rxn<KickChannel> kickChannel = Rxn<KickChannel>();
  FocusNode focus = FocusNode();

  RxList<KickCategory> kickCategories = <KickCategory>[].obs;

  RxBool displayKickPlayer = false.obs;

  Timer? refreshDataTimer;
  late AnimationController refreshDataAnimationController;

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
    refreshDataAnimationController.dispose();
    refreshDataTimer?.cancel();
    super.onClose();
  }

  void refreshData() async {
    refreshDataAnimationController.reset();
    if (homeViewController.kickData == null) {
      return;
    }

    final channelsResult = await getKickChannelsUseCase(
      params: homeViewController.kickData!.accessToken,
    );
    channelsResult.fold(
      (l) => {},
      (r) => kickChannel.value = r.first,
    );
    if (!focus.hasFocus) {
      titleFormController.text = kickChannel.value!.streamTitle;
    }
    refreshDataAnimationController.forward();
  }

  void getKickCategories() async {
    final categories = await getKickCategoriesUseCase(
      params: KickCategoriesParams(
        accessToken: homeViewController.kickData!.accessToken,
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
        accessToken: homeViewController.kickData!.accessToken,
        streamTitle: "",
        categoryId: "",
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
}
