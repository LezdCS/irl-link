import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

Dio initDio() {
  final talker = globals.talker;
  var dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: TalkerDioLoggerSettings(
        requestFilter: (RequestOptions options) => kDebugMode ? true : !options.path.contains('api.twitch.tv'),
        responseFilter: (response) => kDebugMode ? true : ![200, 202].contains(response.statusCode),
      ),
    ),
  );

  return dio;
}
