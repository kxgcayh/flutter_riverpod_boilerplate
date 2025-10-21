import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_riverpod_boilerplate/src/exceptions/api_exception.dart';

part 'api_client.p.dart';

final Provider<Dio> dioProvider = Provider<Dio>(
  (ref) => Dio()
    ..interceptors.add(
      PrettyDioLogger(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseBody: false,
        responseHeader: false,
        error: true,
      ),
    ),
);

final ProviderFamily<ApiClient, String> apiClientProvider = Provider.family((ref, String baseUrl) {
  return ApiClient(ref, baseUrl: baseUrl);
});
