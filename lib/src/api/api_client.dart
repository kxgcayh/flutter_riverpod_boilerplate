import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_boilerplate/src/api/api_exception.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final apiClientProvider = Provider((ref) => ApiClient(ref));

class ApiClient {
  ApiClient(this.ref) : dio = ref.read(dioProvider);

  final Ref ref;
  final Dio dio;

  Future<Response> post(
    url, {
    bool withSignature = true,
    Map<String, dynamic> data = const <String, dynamic>{},
    CancelToken? cancel,
  }) async {
    try {
      return await dio.post(url);
    } on DioException catch (error) {
      throw _errorCatcher(error);
    }
  }

  Future<Response> get(
    String url, {
    String? apiToken,
    CancelToken? cancel,
  }) async {
    try {
      return await dio.get(url);
    } on DioException catch (error) {
      throw _errorCatcher(error);
    }
  }

  Future<void> _errorCatcher(DioException error) {
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
