class CancelException implements Exception {
  final dynamic message;

  CancelException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "CancelException";
    return "CancelException: $message";
  }
}
