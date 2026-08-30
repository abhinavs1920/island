import 'package:flutter/material.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: theme.colorScheme.surfaceContainerHigh,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.surfaceContainerLowest,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      size: 48,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Positioned(
                    top: 75,
                    right: MediaQuery.of(context).size.width / 2 - 48,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.priority_high,
                        size: 16,
                        color: theme.colorScheme.onError,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      'Stay in the loop',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Get notified instantly when a gig posts nearby. Don\'t miss out on high-paying tasks in your area.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.bolt, color: Colors.green.shade600),
                          const SizedBox(width: 12),
                          Text(
                            'Instant alerts for new local gigs',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.blue.shade600),
                          const SizedBox(width: 12),
                          Text(
                            'Be the first to claim high payouts',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('Enable notifications'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Not now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
