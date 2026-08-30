import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../widgets/notification_toggle_item.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationSettingsProvider);
    final notifier = ref.read(notificationSettingsProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF), // background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8FF),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: Text(
          'Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        actions: const [
          SizedBox(width: 48), // balance leading icon
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFC4C5D7), // outline-variant
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NOTIFICATIONS',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7, // 0.05em approximately
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage how TaskRunner communicates with you.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                NotificationToggleItem(
                  title: 'New Task Alerts',
                  subtitle: 'Get notified immediately when a new gig is available in your area.',
                  value: state.newTaskAlerts,
                  onChanged: notifier.toggleNewTaskAlerts,
                ),
                const SizedBox(height: 12),
                NotificationToggleItem(
                  title: 'Earnings Updates',
                  subtitle: 'Receive notifications when your earnings are credited or ready for withdrawal.',
                  value: state.earningsUpdates,
                  onChanged: notifier.toggleEarningsUpdates,
                ),
                const SizedBox(height: 12),
                NotificationToggleItem(
                  title: 'Surge Zone Alerts',
                  subtitle: 'Stay informed about high-demand zones with active multipliers.',
                  value: state.surgeZoneAlerts,
                  onChanged: notifier.toggleSurgeZoneAlerts,
                ),
                const SizedBox(height: 12),
                NotificationToggleItem(
                  title: 'Promotional Offers',
                  subtitle: 'Exclusive rewards, bonuses, and special offers for top riders.',
                  value: state.promotionalOffers,
                  onChanged: notifier.togglePromotionalOffers,
                ),
                const SizedBox(height: 12),
                NotificationToggleItem(
                  title: 'Account Updates',
                  subtitle: 'Important security alerts and updates regarding your TaskRunner profile.',
                  value: state.accountUpdates,
                  onChanged: notifier.toggleAccountUpdates,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
