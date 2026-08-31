import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for SharedPreferences instance (must be overridden in ProviderScope or loaded asynchronously)
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize sharedPreferences in main() and override sharedPreferencesProvider');
});

/// Provider for [PreferencesService]
final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PreferencesService(prefs);
});

/// Service for lightweight non-sensitive key-value preferences
class PreferencesService {
  final SharedPreferences _prefs;

  const PreferencesService(this._prefs);

  static const String keyThemeMode = 'app_theme_mode';
  static const String keyNotificationsEnabled = 'app_notifications_enabled';
  static const String keyImpeller120Fps = 'app_impeller_120fps_enabled';

  // Boolean helpers
  bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  // String helpers
  String? getString(String key) => _prefs.getString(key);

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  // Integer helpers
  int? getInt(String key) => _prefs.getInt(key);

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  // Removal
  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();
}
