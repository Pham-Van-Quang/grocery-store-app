abstract class DataState<T> {
  final T? data;
  final String responseCode;

  DataState({this.data, this.responseCode = ""});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({
    required T data,
  }) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  DataFailed({
    T? data,
  }) : super(data: data);
}
