import 'package:enhanced_enum/enhanced_enum.dart';

part 'api_method_type.g.dart';

@EnhancedEnum()
enum ApiMethodType {
  @EnhancedEnumValue(name: 'GET')
  get,
  @EnhancedEnumValue(name: 'POST')
  post,
  @EnhancedEnumValue(name: 'PUT')
  put,
  @EnhancedEnumValue(name: 'DELETE')
  delete,
}
