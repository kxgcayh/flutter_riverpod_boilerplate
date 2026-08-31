/// Application constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Flutter Boilerplate';
  static const String appVersion = '1.0.0';

  // Network timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Pagination
  static const int defaultPageSize = 25;
}
