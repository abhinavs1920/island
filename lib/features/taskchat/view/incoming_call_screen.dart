import 'package:flutter/material.dart';

class IncomingCallScreen extends StatelessWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.inverseSurface,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Avatar
            Stack(
              alignment: Alignment.center,
              children: [
                // Pulse rings (simplified static for now)
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primaryContainer.withOpacity(0.1),
                  ),
                ),
                Container(
                  width: 176,
                  height: 176,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primaryContainer.withOpacity(0.2),
                  ),
                ),
                // Actual Avatar
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surfaceContainer, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(Icons.person, size: 80, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 48),
            // Call Info
            Text(
              'Incoming Call',
              style: textTheme.displaySmall?.copyWith(
                color: colorScheme.onInverseSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Customer (masked)',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onInverseSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green, // emerald
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Connecting...',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onInverseSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Decline
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.error.withOpacity(0.4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.phone_missed, size: 36, color: colorScheme.onError),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'DECLINE',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.errorContainer,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 48),
                  // Accept
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.green, // emerald
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.phone, size: 36, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'ACCEPT',
                        style: textTheme.labelLarge?.copyWith(
                          color: Colors.green.shade100,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
