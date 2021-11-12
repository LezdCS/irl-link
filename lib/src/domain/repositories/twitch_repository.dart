import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';

abstract class TwitchRepository {
  Future<DataState<TwitchCredentials>> getTwitchOauth(
    TwitchAuthParams params,
  );

  Future<DataState<TwitchCredentials>> getTwitchFromLocal();

  Future<DataState<String>> logout();
}
