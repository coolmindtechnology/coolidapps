enum Level { logOnly, error }

class Failure {
  final String message;

  Failure(this.message);

  @override
  /// Returns a string representation of the `Failure` object.
  ///
  /// This method returns the `message` property of the `Failure` object.
  ///
  /// Returns:
  ///   - A `String` representing the message of the `Failure` object.
  String toString() {
    return message;
  }
}
