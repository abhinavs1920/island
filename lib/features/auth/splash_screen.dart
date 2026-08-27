import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 1)); // Show splash for a bit
    
    if (!mounted) return;
    
    final hasSession = await ref.read(authProvider.notifier).checkSession();
    if (!mounted) return;
    
    if (hasSession) {
      context.go('/home');
    } else {
      context.go('/phone');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003EC7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: 64,
                ),
                const SizedBox(width: 12),
                const Text(
                  'RiderGo',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.64,
                    height: 1.25,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'INITIALIZING SYSTEM',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.8),
                letterSpacing: 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
