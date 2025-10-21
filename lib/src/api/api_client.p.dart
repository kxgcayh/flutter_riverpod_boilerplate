part of 'api_client.dart';

class ApiClient {
  ApiClient(
    this.ref, {
    required this.baseUrl,
  }) : dio = ref.read(dioProvider);

  final Ref ref;
  final Dio dio;
  final String baseUrl;

  Future<Response> post(
    String url, {
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
