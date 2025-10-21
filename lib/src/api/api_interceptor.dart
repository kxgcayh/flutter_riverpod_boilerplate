import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod_boilerplate/src/api/api_method_type.dart';
import 'package:flutter_riverpod_boilerplate/src/utils/app_dev_helper.dart';

class ApiInterceptor extends Interceptor {
  const ApiInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is Map<String, dynamic> && options.method == 'POST') {
      String result = '?';
      for (var map in options.data.entries) {
        result = '$result${map.key}=${map.value}&';
      }
      lg.w('ApiInterceptor(onRequest) == ${options.uri}$result');
    } else {
      lg.i('ApiInterceptor(onRequest) == ${options.uri}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final ApiMethodType? method = ApiMethodType.values.fromString(response.requestOptions.method);
    if (method != null && (method.isPost || method.isPut)) {
      lg.t('ApiInterceptor(onResponse) == ${response.realUri} => ${jsonEncode(response.data)}');
    }
    try {
      // final BaseResponseModel result = BaseResponseModel.fromJson(response.data);
      // if (result.IS_MULTIPLE_LOGGED_IN) {
      //   final String? userId = ref.watch(localUserProvider.select((auth) => auth.userId));
      //   final UserCatalogRepository userCatalogRepository = ref.read(userCatalogRepositoryProvider);
      //   final LocalUserNotifier localUserNotifier = ref.read(localUserProvider.notifier);
      //   if (userId != null) {
      //     final accessTokenResponse = await userCatalogRepository.accessToken(uid: userId);
      //     await localUserNotifier.updateAccessToken(accessTokenResponse.data?.token);
      //   }
      // }
    } catch (error, stack) {
      lg.e('Something went wrong!', error: error, stackTrace: stack);
    } finally {
      super.onResponse(response, handler);
    }
  }
}
