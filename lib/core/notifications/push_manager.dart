import '../../features/home/providers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  PushManager(this.ref);

  void init() {
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onBackgroundMessageTapped);
  }

  void _onForegroundMessage(RemoteMessage message) {
    RemoteLogger.log('FCM Foreground: ${message.messageId}');
    final data = message.data;
    final taskId = data['task_id']?.toString();
    final type = data['type']?.toString(); // e.g., 'new_message', 'status_update', 'new_gig'

    if (type == 'new_gig') {
      // FCM-triggered silent re-fetch for Home Screen
      ref.invalidate(gigsProvider);
    }

    if (_shouldSuppress(taskId, type)) {
      RemoteLogger.log('FCM Suppressed: task_id=$taskId matches current viewing scope');
      return;
    }

    _showBanner(message);
  }

  void _onBackgroundMessageTapped(RemoteMessage message) {
    RemoteLogger.log('FCM Tapped: ${message.messageId}');
    // Navigation logic could go here based on payload if needed
  }

  bool _shouldSuppress(String? taskId, String? type) {
    final scope = ref.read(currentViewingScopeProvider);

    if (type == 'new_gig' && scope is ViewingHome) {
      return true;
    }

    if (taskId == null) return false;

    if (scope is ViewingChat && scope.taskId == taskId && type == 'new_message') {
      return true;
    }
    
    if (scope is ViewingTask && scope.taskId == taskId) {
      // Suppress status updates if we are actively viewing the task detail
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
