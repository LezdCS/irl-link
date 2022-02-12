import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/domain/entities/se_activity.dart';
import 'package:irllink/src/domain/entities/se_song.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';
import 'package:flutter/src/material/tab_controller.dart';

class StreamelementsViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  StreamelementsViewController({required this.streamelementsEvents});

  final StreamelementsEvents streamelementsEvents;

  late TabController tabController;

  late List<SeActivity> activities;
  late ScrollController activitiesScrollController;

  late List<SeSong> songRequestQueue;
  late ScrollController songRequestScrollController;

  @override
  void onInit() {
    tabController = new TabController(length: 2, vsync: this);
    activitiesScrollController = new ScrollController();
    SeActivity a1 = SeActivity(
        id: "1",
        username: "Lezd",
        message: "Ok ok",
        donationAmount: null,
        soundUrl: null,
        activityType: ActivityType.subscription);
    SeActivity a2 = SeActivity(
        id: "2",
        username: "Lezd",
        message: "Ok ok",
        donationAmount: "30",
        soundUrl: null,
        activityType: ActivityType.donation);
    SeActivity a3 = SeActivity(
        id: "3",
        username: "Lezd",
        message: "Ok ok",
        donationAmount: null,
        soundUrl: null,
        activityType: ActivityType.follow);
    SeActivity a4 = SeActivity(
        id: "4",
        username: "Lezd",
        message: "Ok ok",
        donationAmount: "2000",
        soundUrl: null,
        activityType: ActivityType.cheer);
    activities = [a1, a2, a3, a4];

    songRequestScrollController = new ScrollController();
    SeSong s1 = SeSong(
      id: '',
      videoId: "dQw4w9WgXcQ",
      title: "xQc die from an insane and unstoppable laught",
      channel: "xQc",
      duration: "123",
    );
    SeSong s2 = SeSong(
      id: '',
      videoId: "dQw4w9WgXcQ",
      title: "xQc die from an insane and unstoppable laught",
      channel: "xQc",
      duration: "123",
    );
    SeSong s3 = SeSong(
      id: '',
      videoId: "dQw4w9WgXcQ",
      title: "xQc die from an insane and unstoppable laught",
      channel: "xQc",
      duration: "123",
    );
    SeSong s4 = SeSong(
      id: '',
      videoId: "dQw4w9WgXcQ",
      title: "xQc die from an insane and unstoppable laught",
      channel: "xQc",
      duration: "123",
    );
    songRequestQueue = [s1, s2, s3, s4];
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
