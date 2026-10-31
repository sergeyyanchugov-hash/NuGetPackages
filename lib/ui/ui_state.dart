abstract class UiState<T> {}

class UiStateLoading<T> extends UiState<T> {}

class UiStateSuccess<T> extends UiState<T> {
  final T data;
  UiStateSuccess(this.data);
}

class UiStateError<T> extends UiState<T> {
  final String message;
  UiStateError(this.message);
}
