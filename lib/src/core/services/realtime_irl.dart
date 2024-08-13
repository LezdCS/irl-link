import 'dart:async';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/determine_position.dart';
import 'package:irllink/src/core/utils/init_dio.dart';

enum RtIrlStatus {
  updating,
  stopped,
}

class RealtimeIrl {
  String key;

  Rx<RtIrlStatus> status = RtIrlStatus.stopped.obs;
  late Timer timerRtIrl;

  RealtimeIrl(
    this.key,
  );

  Future startTracking() async {
    status.value = RtIrlStatus.updating;
    timerRtIrl = Timer.periodic(const Duration(seconds: 4), (Timer t) async {
      DataState<Position> p = await determinePosition();
      if (p is DataSuccess && status.value == RtIrlStatus.updating) {
        DataState updateResult = await updatePosition(p.data!);
        if (updateResult is DataFailed) {
          status.value = RtIrlStatus.stopped;
          await stopTracking();
        }
      }
    });
  }

  Future<DataState> updatePosition(Position p) async {
    try {
      Response response;
      Dio dio = initDio();
      dio.options.headers["Content-Type"] = "application/json";
      response = await dio.post(
        "https://rtirl.com/api/push?key=$key",
        data: {
          'latitude': p.latitude,
          'longitude': p.longitude,
        },
      );
      status.value = RtIrlStatus.updating;
      return DataSuccess(response.data);
    } on DioException catch (e) {
      status.value = RtIrlStatus.stopped;
      return DataFailed(
        "Unable to update your position on RTIRL : ${e.message}",
      );
    }
  }

  Future<DataState> stopTracking() async {
    try {
      timerRtIrl.cancel();
      Response response;
      Dio dio = initDio();
      status.value = RtIrlStatus.stopped;
      response = await dio.post(
        "https://rtirl.com/api/stop?key=$key",
      );
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(
        "Unable to stop tracking your position on RTIRL : ${e.message}",
      );
    }
  }
}
