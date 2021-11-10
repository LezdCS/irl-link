import 'package:irllink/src/core/params/twitch_request_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch.dart';

abstract class TwitchRepository {
  Future<DataState<Twitch>> getTwitchOauth(
    TwitchRequestParams params,
  );

  Future<DataState<Twitch>> getTwitchFromLocal();
}
