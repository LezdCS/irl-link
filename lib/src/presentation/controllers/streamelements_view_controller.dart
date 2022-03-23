import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/domain/entities/se_activity.dart';
import 'package:irllink/src/domain/entities/se_song.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';

class StreamelementsViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  StreamelementsViewController({required this.streamelementsEvents});

  final StreamelementsEvents streamelementsEvents;

  late TabController tabController;

  late List<SeActivity> activities;
  late ScrollController activitiesScrollController;

  RxList<SeSong> songRequestQueue = <SeSong>[].obs;
  late ScrollController songRequestScrollController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    activitiesScrollController = ScrollController();
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
        message: "",
        donationAmount: null,
        soundUrl: null,
        activityType: ActivityType.follow);
    SeActivity a4 = SeActivity(
        id: "4",
        username: "Lezd",
        message:
            "Ok okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk",
        donationAmount: "2000",
        soundUrl: null,
        activityType: ActivityType.cheer);
    activities = [a1, a2, a3, a4];

    songRequestScrollController = ScrollController();
    SeSong s1 = SeSong(
      id: '',
      videoId: "6x4HDrL1KEU",
      title: "Necrofantasia (Thousand Night Anamnesis)",
      channel: "Delta 3859",
      duration: "123",
    );
    SeSong s2 = SeSong(
      id: '',
      videoId: "qjPJHiCS7Ak",
      title: "xQc CAN'T STOP LAUGHING at UNUSUAL MEMES COMPILATION V175",
      channel: "xQcOW",
      duration: "123",
    );
    SeSong s3 = SeSong(
      id: '',
      videoId: "J_nBbJaAe68",
      title: "【東方】まるで戦闘中！東方好きに送る東方アレンジメドレー！",
      channel: "MM495",
      duration: "123",
    );
    SeSong s4 = SeSong(
      id: '',
      videoId: "cyv7YwXkFnQ",
      title: "don't worry brah (1 hour)",
      channel: "Kopera",
      duration: "123",
    );
    songRequestQueue.value = [s1, s2, s3, s4];
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

  void nextSong() {
    if (songRequestQueue.length > 0) {
      songRequestQueue.removeAt(0);
    }
  }

  void removeSong(SeSong song) {
    songRequestQueue.remove(song);
  }

  void resetQueue() {
    songRequestQueue.clear();
  }
}
