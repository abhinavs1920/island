import 'package:flutter/material.dart';

class LocationPermissionDeniedScreen extends StatelessWidget {
  const LocationPermissionDeniedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_off,
                  size: 64,
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Location access is required',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'To show you gigs nearby and ensure accurate tracking for clients, TaskRunner needs your location permission. Without it, you won\'t be able to receive new tasks.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Open Settings'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Go Back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
