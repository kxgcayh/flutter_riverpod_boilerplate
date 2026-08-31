import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/logging/app_logger.dart';
import 'core/storage/preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  AppLogger.info('Initializing local services and SharedPreferences...');
  final sharedPreferences = await SharedPreferences.getInstance();

  AppLogger.info('Starting FlutterBoilerplateApp with Impeller readiness...');
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const FlutterBoilerplateApp(),
    ),
  );
}
