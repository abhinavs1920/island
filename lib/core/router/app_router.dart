import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/splash_screen.dart';
import '../../features/auth/phone_entry_screen.dart';
import '../../features/auth/otp_verify_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/task_detail/view/task_detail_screen.dart';
import '../../features/task_detail/view/race_lost_screen.dart';
import '../../features/task_detail/view/matched_confirmation_screen.dart';
import '../../features/chat/view/chat_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../../features/permissions/view/location_permission_screen.dart';
import '../../features/permissions/view/notification_permission_screen.dart';
import '../error/view/system_error_screen.dart';
import '../../features/earnings/view/earnings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/phone',
        builder: (context, state) => const PhoneEntryScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpVerifyScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/task/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TaskDetailScreen(taskId: id);
        },
      ),
      GoRoute(
        path: '/race_lost',
        builder: (context, state) => const RaceLostScreen(),
      ),
      GoRoute(
        path: '/matched',
        builder: (context, state) => const MatchedConfirmationScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ChatScreen(taskId: id);
        },
      ),
      GoRoute(
        path: '/permission/location',
        builder: (context, state) => const LocationPermissionScreen(),
      ),
      GoRoute(
        path: '/permission/notification',
        builder: (context, state) => const NotificationPermissionScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/earnings',
        builder: (context, state) => const EarningsScreen(),
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) {
          final errorMessage = state.uri.queryParameters['errorMessage'] ?? state.extra as String?;
          return SystemErrorScreen(errorMessage: errorMessage);
        },
      ),
    ],
  );
});
