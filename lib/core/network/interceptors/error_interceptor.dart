import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';

/// Interceptor that translates [DioException] into strongly-typed [AppException]
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = _mapDioException(err);
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        message: appException.message,
      ),
    );
  }

  AppException _mapDioException(DioException err) {
    return switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError ||
      DioExceptionType.transformTimeout =>
        NetworkException(
          message: 'Connection timed out. Please check your internet.',
          statusCode: err.response?.statusCode,
        ),
      DioExceptionType.badResponse => _mapStatusCode(
          err.response?.statusCode,
          err.response?.data,
        ),
      DioExceptionType.cancel =>
        const NetworkException(message: 'Request was cancelled'),
      DioExceptionType.badCertificate =>
        const NetworkException(message: 'Invalid security certificate'),
      DioExceptionType.unknown => NetworkException(
          message: err.message ?? 'An unexpected network error occurred',
        ),
    };
  }

  AppException _mapStatusCode(int? statusCode, dynamic data) {
    final serverMessage = data is Map<String, dynamic>
        ? data['message']?.toString()
        : null;

    return switch (statusCode) {
      401 => UnauthorizedException(
          message: serverMessage ?? 'Unauthorized. Please login again.',
        ),
      403 => UnauthorizedException(
          message: serverMessage ?? 'Access forbidden.',
        ),
      404 => ServerException(
          message: serverMessage ?? 'Requested resource not found.',
          statusCode: 404,
        ),
      422 || 400 => ValidationException(
          message: serverMessage ?? 'Invalid data provided.',
        ),
      500 || 502 || 503 => ServerException(
          message: serverMessage ?? 'Internal server error. Please try again later.',
          statusCode: statusCode,
        ),
      _ => ServerException(
          message: serverMessage ?? 'Server returned status code: $statusCode',
          statusCode: statusCode,
        ),
    };
  }
}
