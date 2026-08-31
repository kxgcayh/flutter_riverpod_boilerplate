/// Sealed class hierarchy representing failures in the domain & presentation layers
sealed class AppFailure {
  const AppFailure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType(message: $message)';
}

class NetworkFailure extends AppFailure {
  const NetworkFailure([
    super.message =
        'Unable to connect to the network. Please check your connection.',
  ]);
}

class ServerFailure extends AppFailure {
  const ServerFailure({required String message, this.statusCode})
      : super(message);

  final int? statusCode;
}

class CacheFailure extends AppFailure {
  const CacheFailure([super.message = 'Failed to load local data.']);
}

class ValidationFailure extends AppFailure {
  const ValidationFailure({required String message}) : super(message);
}

class UnknownFailure extends AppFailure {
  const UnknownFailure([super.message = 'An unexpected error occurred.']);
}
