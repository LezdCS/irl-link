import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:irllink/src/core/services/talker_service.dart';

import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

Dio initDio(String? baseUrl) {
  Talker talker = Get.find<TalkerService>().talker;
  var dio = Dio(
    BaseOptions(
      baseUrl: baseUrl ?? '',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) =>
          status != null && status >= 200 && status < 500,
    ),
  );
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: TalkerDioLoggerSettings(
        requestFilter: (RequestOptions options) =>
            !options.path.contains('api.twitch.tv'),
        printRequestHeaders: true,
        responseFilter: (response) => ![200, 202].contains(response.statusCode),
      ),
    ),
  );

  return dio;
}
