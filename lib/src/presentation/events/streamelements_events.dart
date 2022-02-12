import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/usecases/streamelements_usecase.dart';

class StreamelementsEvents {
  final StreamelementsUseCase streamelementsUseCase;
  StreamelementsEvents({required this.streamelementsUseCase});

  Future<DataState<void>> login({required StreamelementsAuthParams params}) {
    return streamelementsUseCase.login(params: params);
  }

  Future<DataState<void>> disconnect() {
    return streamelementsUseCase.disconnect();
  }
}
