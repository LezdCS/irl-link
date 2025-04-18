import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  RxBool displayTwitchPlayer = false.obs;
  // @override
  // void onInit() {

  //   super.onInit();
  // }

  // @override
  // void onReady() async {

  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
