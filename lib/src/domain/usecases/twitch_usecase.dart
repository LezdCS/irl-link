import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class TwitchUseCase {
  final TwitchRepository twitchRepository;
  TwitchUseCase({required this.twitchRepository});

  Future<DataState<TwitchCredentials>> getTwitchFromLocal() {
    return twitchRepository.getTwitchFromLocal();
  }

  Future<DataState<TwitchCredentials>> getTwitchOauth(
      {required TwitchAuthParams params}) {
    return twitchRepository.getTwitchOauth(params);
  }

  Future<DataState<String>> logout() {
    return twitchRepository.logout();
  }

  Future<DataState<List<TwitchBadge>>> getTwitchBadges(
      {required String accessToken}) {
    return twitchRepository.getTwitchBadges(accessToken);
  }
}
