import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';

abstract class StreamelementsRepository {
  Future<DataState<void>> login(StreamelementsAuthParams params);
  Future<DataState<void>> disconnect();
}
