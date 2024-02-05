class ServerException implements Exception {
  final dynamic message;

  ServerException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "ServerException";
    return "ServerException: $message";
  }
}
