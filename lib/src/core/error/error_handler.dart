import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'error_codes.dart';
import 'error_messages.dart';
import 'exceptions.dart';
import 'failure.dart';

class ErrorHandler {
  late final Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is FirebaseAuthException) {
      failure = _handleError(error);
    } else if (error is SocketException) {
      failure = const Failure(ErrorMessages.networkConnectionFailed);
    } else if (error is NoInternetConnectionException) {
      failure = const Failure(ErrorMessages.networkConnectionFailed);
    } else {
      failure = const Failure(ErrorMessages.unexpectedError);
    }
  }
}

Failure _handleError(FirebaseAuthException authException) {
  switch (authException.code) {
    case ErrorCodes.weakPassword:
      return const Failure(ErrorMessages.weakPassword);
    case ErrorCodes.existAccount:
    case ErrorCodes.emailIsUsed:
      return const Failure(ErrorMessages.existAccount);
    case ErrorCodes.invalidEmail:
      return const Failure(ErrorMessages.invalidEmail);
    case ErrorCodes.operationNotAllowed:
      return const Failure(ErrorMessages.operationNotAllowed);
    case ErrorCodes.tooManyRequests:
      return const Failure(ErrorMessages.tooManyRequests);
    case ErrorCodes.userDisabled:
      return const Failure(ErrorMessages.userDisabled);
    case ErrorCodes.userNotFound:
      return const Failure(ErrorMessages.userNotFound);
    case ErrorCodes.wrongPassword:
      return const Failure(ErrorMessages.wrongPassword);
    case ErrorCodes.invalidVerificationCode:
      return const Failure(ErrorMessages.invalidVerificationCode);
    case ErrorCodes.invalidVerificationId:
      return const Failure(ErrorMessages.invalidVerificationId);
    case ErrorCodes.networkConnectionFailed:
      return const Failure(ErrorMessages.networkConnectionFailed);
    default:
      return const Failure(ErrorMessages.unexpectedError);
  }
}
