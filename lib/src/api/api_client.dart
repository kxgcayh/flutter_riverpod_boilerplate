import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_boilerplate/src/api/api_exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    ),
);

final ProviderFamily<ApiClient, String> apiClientProvider = Provider.family((ref, String baseUrl) {
  return ApiClient(ref, baseUrl: baseUrl);
});

class ApiClient {
  ApiClient(
    this.ref, {
    required this.baseUrl,
  }) : dio = ref.read(dioProvider);

  final Ref ref;
  final Dio dio;
  final String baseUrl;

  Future<Response> post(
    url, {
    Map<String, dynamic> data = const <String, dynamic>{},
    CancelToken? cancel,
  }) async {
    dio.options.baseUrl = baseUrl;
    try {
      return await dio.post(url, cancelToken: cancel);
    } on DioException catch (error) {
      return _errorCatcher(error);
    }
  }

  Future<Response> get(String url, {CancelToken? cancel}) async {
    dio.options.baseUrl = baseUrl;
    try {
      return await dio.get(url, cancelToken: cancel);
    } on DioException catch (error) {
      return _errorCatcher(error);
    }
  }

  Future<Response> _errorCatcher(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeotException();
      case DioExceptionType.badResponse:
        throw BadResponseException();
      case DioExceptionType.cancel:
        throw ConnectionCanceledException();
      case DioExceptionType.connectionError:
        throw ConnectionErrorException();
      default:
        throw UnknownException();
    }
  }
}
