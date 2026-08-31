import '../errors/failures.dart';

/// Sealed class representing the result of an asynchronous operation
sealed class Result<T> {
  const Result();

  /// Creates a successful result containing [data]
  const factory Result.success(T data) = Success<T>;

  /// Creates a failure result containing [failure]
  const factory Result.failure(AppFailure failure) = Failure<T>;

  /// Helper getter to check if result is success
  bool get isSuccess => this is Success<T>;

  /// Helper getter to check if result is failure
  bool get isFailure => this is Failure<T>;

  /// Fold helper to match on Success and Failure
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(AppFailure failure) onFailure,
  }) {
    return switch (this) {
      Success<T>(data: final data) => onSuccess(data),
      Failure<T>(failure: final failure) => onFailure(failure),
    };
  }
}

/// Success result containing [data]
final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Result.success($data)';
}

/// Failure result containing [failure]
final class Failure<T> extends Result<T> {
  const Failure(this.failure);

  final AppFailure failure;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          failure == other.failure;

  @override
  int get hashCode => failure.hashCode;

  @override
  String toString() => 'Result.failure($failure)';
}
