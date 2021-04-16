enum AsyncState {
  pending,
  complete,
  error,
}

class AsyncInfo {
  final AsyncState asyncStatus;
  final Exception? exception;

  const AsyncInfo({
    this.asyncStatus = AsyncState.pending,
    this.exception,
  });

  factory AsyncInfo.complete() {
    return AsyncInfo(asyncStatus: AsyncState.complete);
  }

  factory AsyncInfo.error(Exception exception) {
    return AsyncInfo(
      asyncStatus: AsyncState.error,
      exception: exception,
    );
  }
}

abstract class AsyncViewModel {
  AsyncInfo get asyncStatus;
  Function? get refresh;
}
