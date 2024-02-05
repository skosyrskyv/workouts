import 'package:workouts/core/network/client/error/error_model/error_model.dart';

class ClientException implements Exception {
  final ErrorModel error;
  ClientException(this.error);

  String get message => error.errors.first.detail;
  String get messages {
    String result = '';
    for (var element in error.errors) {
      result += '${element.detail}\n';
    }
    return result;
  }

  @override
  String toString() {
    final String errorMessage = error.errors.first.detail;
    if (errorMessage.isEmpty) return "ClientException";
    return "ClientException: $messages";
  }
}
