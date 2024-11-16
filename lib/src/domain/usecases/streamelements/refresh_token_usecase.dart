import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsRefreshTokenUseCase
    implements UseCase<DataState<SeCredentials>, SeCredentials> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsRefreshTokenUseCase({required this.streamelementsRepository});

  @override
  Future<DataState<SeCredentials>> call({required SeCredentials params}) {
    return streamelementsRepository.refreshAccessToken(params);
  }
}
