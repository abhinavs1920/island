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
  await Firebase.initializeApp();
  
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://gpepmnsfsxjlsuentdta.supabase.co'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdwZXBtbnNmc3hqbHN1ZW50ZHRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc3NjQzNjIsImV4cCI6MjEwMzM0MDM2Mn0.gE7PlhE21Hy0o8HLUgXFEAFxxZLf86BRMfNxcXOmAKU'),
  );

  runApp(const ProviderScope(child: RiderApp()));
}

class RiderApp extends ConsumerWidget {
  const RiderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Flikk',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
