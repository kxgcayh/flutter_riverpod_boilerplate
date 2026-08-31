import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Settings state representing user configuration
class SettingsState {
  const SettingsState({
    this.notificationsEnabled = true,
    this.soundEffectsEnabled = true,
    this.readReceiptsEnabled = true,
    this.highRefreshRateEnabled = true,
  });

  final bool notificationsEnabled;
  final bool soundEffectsEnabled;
  final bool readReceiptsEnabled;
  final bool highRefreshRateEnabled;

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? soundEffectsEnabled,
    bool? readReceiptsEnabled,
    bool? highRefreshRateEnabled,
  }) {
    return SettingsState(
      notificationsEnabled:
          notificationsEnabled ?? this.notificationsEnabled,
      soundEffectsEnabled: soundEffectsEnabled ?? this.soundEffectsEnabled,
      readReceiptsEnabled: readReceiptsEnabled ?? this.readReceiptsEnabled,
      highRefreshRateEnabled:
          highRefreshRateEnabled ?? this.highRefreshRateEnabled,
    );
  }
}

class SettingsViewModel extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    return const SettingsState();
  }

  void toggleNotifications(bool value) {
    state = state.copyWith(notificationsEnabled: value);
  }

  void toggleSound(bool value) {
    state = state.copyWith(soundEffectsEnabled: value);
  }

  void toggleReadReceipts(bool value) {
    state = state.copyWith(readReceiptsEnabled: value);
  }

  void toggleHighRefreshRate(bool value) {
    state = state.copyWith(highRefreshRateEnabled: value);
  }
}

final settingsViewModelProvider =
    NotifierProvider<SettingsViewModel, SettingsState>(
  SettingsViewModel.new,
);
