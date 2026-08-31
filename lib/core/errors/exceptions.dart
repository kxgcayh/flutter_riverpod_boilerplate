/// Base exception class for all custom exceptions
sealed class AppException implements Exception {
  const AppException(this.message, [this.statusCode]);

  final String message;
  final int? statusCode;

  @override
  String toString() => '$runtimeType: $message (statusCode: $statusCode)';
}

/// Network communication exception
class NetworkException extends AppException {
  const NetworkException({required String message, int? statusCode})
      : super(message, statusCode);
}

/// Server returned an error response
class ServerException extends AppException {
  const ServerException({required String message, int? statusCode})
      : super(message, statusCode);
}

/// Local storage / Cache exception
class CacheException extends AppException {
  const CacheException({required String message}) : super(message);
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException({required String message}) : super(message);
}

/// Unauthorized / Session expired exception
class UnauthorizedException extends AppException {
  const UnauthorizedException({String message = 'Unauthorized access'})
      : super(message, 401);
}
