import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';
import '../viewmodels/settings_view_model.dart';

/// App Settings Screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);
    final settings = ref.watch(settingsViewModelProvider);
    final settingsNotifier = ref.read(settingsViewModelProvider.notifier);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          const _SectionHeader(title: 'APPEARANCE'),
          _SettingsContainer(
            children: [
              ListTile(
                leading: const Icon(Icons.palette_outlined),
                title: const Text('Theme Mode'),
                subtitle: Text(_getThemeModeName(themeMode)),
                trailing: DropdownButton<ThemeMode>(
                  value: themeMode,
                  underline: const SizedBox(),
                  onChanged: (mode) {
                    if (mode != null) themeNotifier.setThemeMode(mode);
                  },
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System Default'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light Mode'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark Mode'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _SectionHeader(title: 'PERFORMANCE & ENGINE'),
          _SettingsContainer(
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.speed_rounded),
                title: const Text('Impeller 120 FPS Mode'),
                subtitle: const Text('Enable ultra-smooth high refresh rate rendering'),
                value: settings.highRefreshRateEnabled,
                onChanged: settingsNotifier.toggleHighRefreshRate,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _SectionHeader(title: 'NOTIFICATIONS & CHAT'),
          _SettingsContainer(
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications_outlined),
                title: const Text('Push Notifications'),
                value: settings.notificationsEnabled,
                onChanged: settingsNotifier.toggleNotifications,
              ),
              const Divider(height: 1),
              SwitchListTile(
                secondary: const Icon(Icons.volume_up_outlined),
                title: const Text('In-App Sounds'),
                value: settings.soundEffectsEnabled,
                onChanged: settingsNotifier.toggleSound,
              ),
              const Divider(height: 1),
              SwitchListTile(
                secondary: const Icon(Icons.done_all_rounded),
                title: const Text('Read Receipts'),
                subtitle: const Text('Let others know when you\'ve seen their messages'),
                value: settings.readReceiptsEnabled,
                onChanged: settingsNotifier.toggleReadReceipts,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _SectionHeader(title: 'ABOUT'),
          _SettingsContainer(
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text('Version'),
                trailing: Text(
                  'v${AppConstants.appVersion}',
                  style: TextStyle(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ),
              const Divider(height: 1),
              const ListTile(
                leading: Icon(Icons.code_rounded),
                title: Text('Architecture'),
                trailing: Text('Feature-First MVVM'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'System Default',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}

class _SettingsContainer extends StatelessWidget {
  const _SettingsContainer({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.8,
        ),
      ),
      child: Column(children: children),
    );
  }
}
