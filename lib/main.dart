import 'dart:ui';
import 'core/notifications/push_manager.dart';
import 'core/providers/location_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/utils/remote_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RemoteLogger.init();

  // 1. Global Flutter Error Interceptor
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    RemoteLogger.log('FLUTTER_ERROR: ${details.exceptionAsString()}\n${details.stack}');
  };

  // 2. Global Asynchronous Platform Error Interceptor
  PlatformDispatcher.instance.onError = (error, stack) {
    RemoteLogger.log('ASYNC_PLATFORM_ERROR: $error\n$stack');
    return true;
  };

  // 3. Global Visual Error Fallback Screen (Replaces silent white/grey screens with detailed debug diagnostics)
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: const Color(0xFF0F172A),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.bug_report, color: Colors.redAccent, size: 28),
                    SizedBox(width: 8),
                    Text(
                      'DIAGNOSTIC CRASH REPORT',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                  ),
                  child: Text(
                    details.exceptionAsString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'STACKTRACE:',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    details.stack.toString(),
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };

  try {
    if (!kIsWeb) {
      await Firebase.initializeApp();
    }
  } catch (e) {
    RemoteLogger.log('Firebase init: $e');
  }
  
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://gpepmnsfsxjlsuentdta.supabase.co'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdwZXBtbnNmc3hqbHN1ZW50ZHRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc3NjQzNjIsImV4cCI6MjEwMzM0MDM2Mn0.gE7PlhE21Hy0o8HLUgXFEAFxxZLf86BRMfNxcXOmAKU'),
  );

  runApp(const ProviderScope(child: RiderApp()));
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class RiderApp extends ConsumerWidget {
  const RiderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Initialize PushManager once
    ref.listenManual(pushManagerProvider, (_, __) {});

    // Start background location tracking immediately on app launch
    ref.listenManual(locationProvider, (_, __) {});
    
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flikk',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
