import 'package:dio/dio.dart';
import '../../logging/app_logger.dart';

/// Interceptor that logs network traffic via [AppLogger]
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('🌐 HTTP REQUEST: [${options.method}] ${options.uri}');
    if (options.data != null) {
      AppLogger.debug('📦 Request Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    AppLogger.debug(
      '✅ HTTP RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '❌ HTTP ERROR: [${err.response?.statusCode}] ${err.requestOptions.uri} | Message: ${err.message}',
      err,
      err.stackTrace,
    );
    super.onError(err, handler);
  }
}
