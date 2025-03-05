import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/route_manager.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/determine_position.dart';

import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

enum RtIrlStatus {
  updating,
  stopped,
}

class RealtimeIrl {
  String key;

  Rx<RtIrlStatus> status = RtIrlStatus.stopped.obs;
  Talker talker = Get.find<TalkerService>().talker;
  Dio dioClient = initDio('https://rtirl.com/api');

  RealtimeIrl(
    this.key,
  );

  Future<void> onReceiveTaskData(data) async {
    if (data is Map<String, dynamic>) {
      final dynamic action = data["action"];
      switch (action) {
        case 'repeat':
          status.value = RtIrlStatus.updating;
          final positionResult = await determinePosition();
          positionResult.fold(
            (l) {},
            (r) async {
              if (status.value == RtIrlStatus.updating) {
                talker.info(
                  "Updating position on RTIRL: ${r.latitude}, ${r.longitude} at ${data['timestampMillis']}",
                );
                final updateResult = await updatePosition(r);

                updateResult.fold(
                  (l) async {
                    status.value = RtIrlStatus.stopped;
                    await stopTracking();
                  },
                  (r) {},
                );
              }
            },
          );

        case 'rtirl_stop':
          await stopTracking();
        default:
          talker.info("Unknown action: $action");
      }
    }
  }

  Future<Either<Failure, void>> updatePosition(Position p) async {
    try {
      await dioClient.post(
        "/push?key=$key",
        data: {
          'latitude': p.latitude,
          'longitude': p.longitude,
        },
      );
      status.value = RtIrlStatus.updating;
      return const Right(null);
    } on DioException catch (e) {
      status.value = RtIrlStatus.stopped;
      return Left(
        Failure("Unable to update your position on RTIRL : ${e.message}"),
      );
    }
  }

  Future<Either<Failure, void>> stopTracking() async {
    try {
      FlutterForegroundTask.stopService();
      status.value = RtIrlStatus.stopped;
      await dioClient.post(
        "/stop?key=$key",
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        Failure(
          "Unable to stop tracking your position on RTIRL : ${e.message}",
        ),
      );
    }
  }
}
