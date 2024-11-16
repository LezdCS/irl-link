import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsGetMeParams {
  final String token;

  StreamElementsGetMeParams({
    required this.token,
  });
}

class StreamElementsGetMeUseCase
    implements UseCase<DataState<SeMe>, StreamElementsGetMeParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsGetMeUseCase({required this.streamelementsRepository});

  @override
  Future<DataState<SeMe>> call({required StreamElementsGetMeParams params}) {
    return streamelementsRepository.getMe(params.token);
  }
}
