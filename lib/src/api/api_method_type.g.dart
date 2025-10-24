// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_method_type.dart';

// **************************************************************************
// EnhancedEnumGenerator
// **************************************************************************

extension ApiMethodTypeFromStringExtension on Iterable<ApiMethodType> {
  ApiMethodType? fromString(String val) {
    final override = {
      'GET': ApiMethodType.get,
      'POST': ApiMethodType.post,
      'PUT': ApiMethodType.put,
      'DELETE': ApiMethodType.delete,
    }[val];
    // ignore: unnecessary_this
    return this.contains(override) ? override : null;
  }
}

extension ApiMethodTypeEnhancedEnum on ApiMethodType {
  @override
  // ignore: override_on_non_overriding_member
  String get name => {
    ApiMethodType.get: 'GET',
    ApiMethodType.post: 'POST',
    ApiMethodType.put: 'PUT',
    ApiMethodType.delete: 'DELETE',
  }[this]!;
  bool get isGet => this == ApiMethodType.get;
  bool get isPost => this == ApiMethodType.post;
  bool get isPut => this == ApiMethodType.put;
  bool get isDelete => this == ApiMethodType.delete;
  T when<T>({
    required T Function() get,
    required T Function() post,
    required T Function() put,
    required T Function() delete,
  }) => {
    ApiMethodType.get: get,
    ApiMethodType.post: post,
    ApiMethodType.put: put,
    ApiMethodType.delete: delete,
  }[this]!();
  T maybeWhen<T>({
    T? Function()? get,
    T? Function()? post,
    T? Function()? put,
    T? Function()? delete,
    required T Function() orElse,
  }) =>
      {
        ApiMethodType.get: get,
        ApiMethodType.post: post,
        ApiMethodType.put: put,
        ApiMethodType.delete: delete,
      }[this]?.call() ??
      orElse();
}
