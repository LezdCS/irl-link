import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';
import 'package:flutter/src/material/tab_controller.dart';

class StreamelementsViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  StreamelementsViewController({required this.streamelementsEvents});

  final StreamelementsEvents streamelementsEvents;

  late TabController tabController;
  late ScrollController activitiesScrollController;
  late List activities;

  @override
  void onInit() {
    tabController = new TabController(length: 2, vsync: this);
    activitiesScrollController = new ScrollController();
    activities = ["1", "2", "3", "4", "5", "6"];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    StreamelementsAuthParams params = StreamelementsAuthParams();
    await streamelementsEvents.login(params: params);
  }
}
