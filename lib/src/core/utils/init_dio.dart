import 'package:dio/dio.dart';
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
        responseFilter: (response) => ![200, 202].contains(response.statusCode),
      ),
    ),
  );

  return dio;
}
