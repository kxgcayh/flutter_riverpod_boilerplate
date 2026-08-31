import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_boilerplate/core/storage/preferences_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PreferencesService', () {
    late PreferencesService preferencesService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        PreferencesService.keyThemeMode: 1, // Light
        PreferencesService.keyNotificationsEnabled: true,
      });
      final prefs = await SharedPreferences.getInstance();
      preferencesService = PreferencesService(prefs);
    });

    test('reads stored booleans and integers correctly', () {
      expect(preferencesService.getInt(PreferencesService.keyThemeMode), equals(1));
      expect(preferencesService.getBool(PreferencesService.keyNotificationsEnabled), isTrue);
      expect(preferencesService.getBool('non_existent_key', defaultValue: false), isFalse);
    });

    test('persists values and supports deletion', () async {
      await preferencesService.setBool('custom_flag', true);
      expect(preferencesService.getBool('custom_flag'), isTrue);

      await preferencesService.setString('api_env', 'staging');
      expect(preferencesService.getString('api_env'), equals('staging'));

      await preferencesService.remove('custom_flag');
      expect(preferencesService.getBool('custom_flag', defaultValue: false), isFalse);
    });
  });
}
