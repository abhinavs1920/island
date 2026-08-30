import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Enable Location',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'So we can match you to nearby gigs and help you navigate to your tasks efficiently.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () => context.go('/permission/notification'),
                  child: const Text('Allow location'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Not now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
