import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';

abstract class TwitchRepository {
  Future<DataState<TwitchCredentials>> getTwitchOauth(
    TwitchAuthParams params,
  );

  Future<DataState<TwitchCredentials>> refreshAccessToken(
    TwitchCredentials twitchData,
  );

  Future<DataState<TwitchCredentials>> getTwitchFromLocal();

  Future<void> setTwitchOnLocal(
    TwitchCredentials twitchData,
  );

  Future<DataState<String>> logout();

  Future<DataState<TwitchUser>> getTwitchUser(
    String username,
    String accessToken,
  );
}
