class TimeoutException implements Exception {
  final dynamic message;

  TimeoutException([this.message]) : super();

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "TimeoutException";
    return "TimeoutException: $message";
  }
}
