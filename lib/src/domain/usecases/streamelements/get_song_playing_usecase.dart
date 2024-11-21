import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsGetSongPlayingParams {
  final String token;
  final String channel;

  StreamElementsGetSongPlayingParams({
    required this.token,
    required this.channel,
  });
}

class StreamElementsGetSongPlayingUseCase
    implements UseCase<DataState<SeSong>, StreamElementsGetSongPlayingParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsGetSongPlayingUseCase({required this.streamelementsRepository});

  @override
  Future<DataState<SeSong>> call(
      {required StreamElementsGetSongPlayingParams params,}) {
    return streamelementsRepository.getSongPlaying(
        params.token, params.channel,);
  }
}
