import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsDisconnectUseCase
    implements UseCase<DataState<void>, String> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsDisconnectUseCase({required this.streamelementsRepository});

  @override
  Future<DataState<void>> call({required String params}) {
    return streamelementsRepository.disconnect(params);
  }
}
