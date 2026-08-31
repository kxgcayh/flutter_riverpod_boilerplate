import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app.dart';
import 'core/logging/app_logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.info('Starting FlutterBoilerplateApp with Impeller readiness...');
  runApp(
    const ProviderScope(
      child: FlutterBoilerplateApp(),
    ),
  );
}
