import '../../features/home/providers/home_controller.dart';
import '../../features/home/models/gig_model.dart';
import '../../features/notifications/widgets/gig_notification_banner.dart';
import '../router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import '../providers/viewing_scope_provider.dart';
import '../../main.dart';
import '../utils/remote_logger.dart';

final pushManagerProvider = Provider<PushManager>((ref) {
  final manager = PushManager(ref);
  manager.init();
  return manager;
});

class PushManager {
  final Ref ref;
  OverlayEntry? _currentGigOverlay;

  PushManager(this.ref);

  void init() {
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onBackgroundMessageTapped);
  }

  void _onForegroundMessage(RemoteMessage message) {
    RemoteLogger.log('FCM Foreground: ${message.messageId}');
    final data = message.data;
    final taskId = data['task_id']?.toString();
    final type = data['type']?.toString();

    // 1. If it's a new gig offer / alert
    if (type == 'new_gig' || type == 'task_posted' || type == 'new_gig_alert') {
      ref.invalidate(gigsProvider);

      if (taskId != null && taskId.isNotEmpty) {
        final title = message.notification?.title ?? data['title'] ?? data['category'] ?? 'New Gig Nearby';
        final category = data['category']?.toString() ?? 'Task';
        final description = message.notification?.body ?? data['body'] ?? data['description'] ?? '';
        final price = double.tryParse(data['price']?.toString() ?? data['payout']?.toString() ?? '85') ?? 85.0;
        final distance = data['distance']?.toString() ?? '~nearby';
        final duration = data['duration']?.toString() ?? '30 mins';

        final gig = Gig(
          id: taskId,
          title: title,
          category: category,
          price: price,
          description: description,
          distance: distance,
          duration: duration,
          icon: 'assignment',
        );

        showGigOverlay(gig);
        return;
      }
    }

    if (_shouldSuppress(taskId, type)) {
      RemoteLogger.log('FCM Suppressed: task_id=$taskId matches current viewing scope');
      return;
    }

    _showBanner(message);
  }

  void showGigOverlay(Gig gig) {
    _currentGigOverlay?.remove();
    _currentGigOverlay = null;

    final overlayState = rootNavigatorKey.currentState?.overlay;
    if (overlayState == null) return;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        left: 8,
        right: 8,
        child: GigNotificationBanner(
          gig: gig,
          onDismiss: () {
            if (_currentGigOverlay == entry) {
              entry.remove();
              _currentGigOverlay = null;
            }
          },
        ),
      ),
    );

    _currentGigOverlay = entry;
    overlayState.insert(entry);
  }

  void _onBackgroundMessageTapped(RemoteMessage message) {
    RemoteLogger.log('FCM Tapped: ${message.messageId}');
    final data = message.data;
    final taskId = data['task_id']?.toString();
    final type = data['type']?.toString();

    if (taskId != null && taskId.isNotEmpty) {
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        if (type == 'new_gig' || type == 'task_posted' || type == 'new_gig_alert') {
          final title = message.notification?.title ?? data['title'] ?? data['category'] ?? 'New Gig Nearby';
          final category = data['category']?.toString() ?? 'Task';
          final description = message.notification?.body ?? data['body'] ?? '';
          final price = double.tryParse(data['price']?.toString() ?? data['payout']?.toString() ?? '85') ?? 85.0;
          final distance = data['distance']?.toString() ?? '~nearby';
          final duration = data['duration']?.toString() ?? '30 mins';

          final gig = Gig(
            id: taskId,
            title: title,
            category: category,
            price: price,
            description: description,
            distance: distance,
            duration: duration,
            icon: 'assignment',
          );

          showGigOverlay(gig);
        } else {
          context.push('/task/$taskId');
        }
      }
    }
  }

  bool _shouldSuppress(String? taskId, String? type) {
    final scope = ref.read(currentViewingScopeProvider);

    if (taskId == null) return false;

    if (scope is ViewingChat && scope.taskId == taskId && type == 'new_message') {
      return true;
    }

    if (scope is ViewingTask && scope.taskId == taskId) {
      return true;
    }

    return false;
  }

  void _showBanner(RemoteMessage message) {
    final title = message.notification?.title ?? message.data['title'] ?? 'New Notification';
    final body = message.notification?.body ?? message.data['body'] ?? '';

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (body.isNotEmpty) Text(body),
          ],
        ),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
