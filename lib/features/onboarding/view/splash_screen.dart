import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_shipping,
                  size: 64,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(width: 12),
                Text(
                  'RiderGo',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.02,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
                strokeWidth: 4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'INITIALIZING SYSTEM',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
