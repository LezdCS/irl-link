import 'package:irllink/src/core/params/twitch_request_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/entities/twitch.dart';

class TwitchUseCase {
  final TwitchRepositoryImpl twitchRepositoryImpl;
  TwitchUseCase({required this.twitchRepositoryImpl});

  Future<DataState<Twitch>> getTwitchOauth({TwitchRequestParams? params}) {
    return twitchRepositoryImpl.getTwitchOauth(params!);
  }
}
