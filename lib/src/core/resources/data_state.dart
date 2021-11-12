import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final Exception? exception;

  const DataState({
    this.data,
    this.exception,
  });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Exception exception) : super(exception: exception);
}
