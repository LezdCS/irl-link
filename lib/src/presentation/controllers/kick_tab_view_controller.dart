import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/kick/kick_category.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_categories_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/patch_kick_channel_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class KickTabViewController extends GetxController
    with GetTickerProviderStateMixin {
  KickTabViewController({
    required this.patchKickChannelUseCase,
    required this.getKickCategoriesUseCase,
    required this.homeViewController,
  });

  final PatchKickChannelUseCase patchKickChannelUseCase;
  final GetKickCategoriesUseCase getKickCategoriesUseCase;
  final HomeViewController homeViewController;

  late TextEditingController titleFormController;
  RxString streamTitle = "".obs;
  FocusNode focus = FocusNode();

  RxList<KickCategory> kickCategories = <KickCategory>[].obs;

  RxBool displayKickPlayer = false.obs;

  @override
  void onInit() {
    getKickCategories();
    titleFormController = TextEditingController();
    super.onInit();
  }

  // @override
  // void onReady() async {

  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

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
