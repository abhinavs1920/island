import 'package:flutter/material.dart';

class IncomingTaskAlertBottomSheet extends StatelessWidget {
  const IncomingTaskAlertBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'EST. PAYOUT',
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: theme.colorScheme.secondary,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  Text(
                                    '₹85.00',
                                    style: theme.textTheme.headlineMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.route,
                                    size: 20,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '2.4 km total distance',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.errorContainer,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.local_fire_department,
                                          size: 14,
                                          color: theme.colorScheme.error,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'High Demand',
                                          style: theme.textTheme.labelMedium?.copyWith(
                                            color: theme.colorScheme.error,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                padding: const EdgeInsets.only(left: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: theme.colorScheme.surfaceVariant,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildTimelineItem(
                                      context,
                                      title: 'Pickup',
                                      subtitle: '123 Maple St, Business District',
                                      isPrimary: true,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildTimelineItem(
                                      context,
                                      title: 'Dropoff',
                                      subtitle: '456 Pine Ave, Residential Zone',
                                      isPrimary: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(color: theme.colorScheme.surfaceVariant),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        foregroundColor: theme.colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () {},
                      child: const Text('Accept Task'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Decline'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isPrimary,
  }) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -25,
          top: 4,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isPrimary ? theme.colorScheme.primary : theme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: isPrimary ? theme.colorScheme.surface : theme.colorScheme.outlineVariant,
                width: 2,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
