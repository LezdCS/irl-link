import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsGetOverlaysParams {
  final String token;
  final String channel;

  StreamElementsGetOverlaysParams({
    required this.token,
    required this.channel,
  });
}

class StreamElementsGetOverlaysUseCase
    implements
        UseCase<DataState<List<SeOverlay>>, StreamElementsGetOverlaysParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsGetOverlaysUseCase({required this.streamelementsRepository});

  @override
  Future<DataState<List<SeOverlay>>> call({
    required StreamElementsGetOverlaysParams params,
  }) {
    return streamelementsRepository.getOverlays(params.token, params.channel);
  }
}
