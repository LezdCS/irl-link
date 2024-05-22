import 'package:irllink/src/core/utils/globals.dart' as globals;

abstract class DataState<T> {
  final T? data;
  final String? error;

  DataState({
    this.data,
    this.error,
  }) {
    if(error != null) {
      globals.talker?.error(error);
    }
  }
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(String error) : super(error: error);
}
