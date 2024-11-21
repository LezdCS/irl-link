import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsGetLocalCredentialsUseCase
    implements UseCase<DataState<SeCredentials>, void> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsGetLocalCredentialsUseCase(
      {required this.streamelementsRepository,});

  @override
  Future<DataState<SeCredentials>> call({void params}) {
    return streamelementsRepository.getSeCredentialsFromLocal();
  }
}
