import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SettingsStatus { loading, normal, success }

class SettingsNotifier extends StateNotifier<SettingsStatus> {
  SettingsNotifier() : super(SettingsStatus.loading) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    state = SettingsStatus.loading;
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    state = SettingsStatus.normal;
  }

  void saveSettings() {
    state = SettingsStatus.success;
    // Hide success after a few seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        state = SettingsStatus.normal;
      }
    });
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsStatus>((ref) {
  return SettingsNotifier();
});

class NotificationSettingsState {
  final bool newTaskAlerts;
  final bool earningsUpdates;
  final bool surgeZoneAlerts;
  final bool promotionalOffers;
  final bool accountUpdates;

  NotificationSettingsState({
    this.newTaskAlerts = true,
    this.earningsUpdates = true,
    this.surgeZoneAlerts = false,
    this.promotionalOffers = true,
    this.accountUpdates = true,
  });

  NotificationSettingsState copyWith({
    bool? newTaskAlerts,
    bool? earningsUpdates,
    bool? surgeZoneAlerts,
    bool? promotionalOffers,
    bool? accountUpdates,
  }) {
    return NotificationSettingsState(
      newTaskAlerts: newTaskAlerts ?? this.newTaskAlerts,
      earningsUpdates: earningsUpdates ?? this.earningsUpdates,
      surgeZoneAlerts: surgeZoneAlerts ?? this.surgeZoneAlerts,
      promotionalOffers: promotionalOffers ?? this.promotionalOffers,
      accountUpdates: accountUpdates ?? this.accountUpdates,
    );
  }
}

class NotificationSettingsNotifier extends StateNotifier<NotificationSettingsState> {
  NotificationSettingsNotifier() : super(NotificationSettingsState());

  void toggleNewTaskAlerts(bool value) {
    state = state.copyWith(newTaskAlerts: value);
  }

  void toggleEarningsUpdates(bool value) {
    state = state.copyWith(earningsUpdates: value);
  }

  void toggleSurgeZoneAlerts(bool value) {
    state = state.copyWith(surgeZoneAlerts: value);
  }

  void togglePromotionalOffers(bool value) {
    state = state.copyWith(promotionalOffers: value);
  }

  void toggleAccountUpdates(bool value) {
    state = state.copyWith(accountUpdates: value);
  }
}

final notificationSettingsProvider = StateNotifierProvider<NotificationSettingsNotifier, NotificationSettingsState>((ref) {
  return NotificationSettingsNotifier();
});
