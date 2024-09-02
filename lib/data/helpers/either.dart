class Either<L, R> {
  late final dynamic _data;
  late final bool _failed;

  Either.success(R o) {
    _data = o;
    _failed = false;
  }
  Either.error(L o) {
    _data = o;
    _failed = true;
  }

  bool get isFailed => _failed;

  // Executes the error function if the result is a failure, passing the failed data as a parameter.
  // Executes the success function if the result is a success, passing the success data as a parameter.
  void when({
    required void Function(L failed) error,
    required void Function(R success) success,
  }) {
    if (_failed) {
      error(_data);
    } else {
      success(_data);
    }
  }

  // Executes the provided error function if the Either instance represents a failure, 
  // otherwise executes the success function. Both error and success functions are asynchronous.
  Future<void> whenAsync({
    required Future<void> Function(L failed) error,
    required Future<void> Function(R success) success,
  }) async {
    if (_failed) {
      await error(_data);
    } else {
      await success(_data);
    }
  }
}
