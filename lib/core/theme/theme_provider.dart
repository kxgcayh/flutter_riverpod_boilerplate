import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../storage/preferences_service.dart';

/// Notifier to manage and persist application ThemeMode
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    try {
      final prefs = ref.watch(preferencesServiceProvider);
      final savedIndex = prefs.getInt(PreferencesService.keyThemeMode);
      if (savedIndex != null &&
          savedIndex >= 0 &&
          savedIndex < ThemeMode.values.length) {
        return ThemeMode.values[savedIndex];
      }
    } catch (_) {
      // Fallback for isolated widget tests without SharedPreferences override
    }
    return ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    try {
      final prefs = ref.read(preferencesServiceProvider);
      prefs.setInt(PreferencesService.keyThemeMode, mode.index);
    } catch (_) {}
  }

  void toggleTheme() {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setThemeMode(next);
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
