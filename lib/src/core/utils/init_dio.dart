import 'package:dio/dio.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

Dio initDio() {
  final talker = globals.talker;
  var dio = Dio();
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
