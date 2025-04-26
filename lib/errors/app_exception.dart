abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class NotFoundException extends AppException {
  NotFoundException(super.message);
}

class ValidationException extends AppException {
  ValidationException(super.message);
}

class InternalServerException extends AppException {
  InternalServerException(super.message);
}
