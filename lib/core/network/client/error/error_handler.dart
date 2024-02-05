import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:workouts/constants/locale_keys.g.dart';
import 'package:workouts/core/network/client/exceptions/server_exception.dart';

import '../exceptions/client_exception.dart';
import '../exceptions/timeout_exception.dart';

String errorHandler(Object exception) {
  log(exception.toString());
  String message = LocaleKeys.common_error.tr();

  if (exception is ServerException) {
    message = LocaleKeys.server_error.tr();
  }
  if (exception is ClientException) {
    message = exception.messages;
  }
  if (exception is TimeoutException) {
    message = LocaleKeys.connection_error.tr();
  }

  return message;
}
