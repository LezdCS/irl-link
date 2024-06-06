import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/init_dio.dart';

enum RtIrlStatus {
  updating,
  stopped,
}

class RealtimeIrl {
  String key;

  RtIrlStatus status = RtIrlStatus.stopped;

  RealtimeIrl(
    this.key,
  );

  Future<DataState<bool>> updatePosition(Position p) async {
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
      status = RtIrlStatus.updating;
      return DataSuccess(response.data);
    } on DioException catch (e) {
      status = RtIrlStatus.stopped;
      return DataFailed(
        "Unable to update your position on RTIRL : ${e.message}",
      );
    }
  }

  Future<DataState> stopTracking() async {
    try {
      Response response;
      Dio dio = initDio();
      response = await dio.post(
        "https://rtirl.com/api/stop?key=$key",
      );
      status = RtIrlStatus.stopped;
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(
        "Unable to stop tracking your position on RTIRL : ${e.message}",
      );
    }
  }
}
