import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromServerFailureFirebase(Exception exception) {
    if (exception is FirebaseException) {
      // Handle Firebase exceptions
      String errorMessage = exception.message ?? 'Unknown Firebase error';
      return ServerFailure(errorMessage);
    } else {
      // Handle other exceptions
      String errorMessage = exception.toString() ?? 'Unknown error';
      return ServerFailure(errorMessage);
    }
  }
}
