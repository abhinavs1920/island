import 'package:flutter/material.dart';

class MaskedCallScreen extends StatelessWidget {
  const MaskedCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.inverseSurface,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.inverseSurface,
                    colorScheme.onSurface,
                  ],
                ),
              ),
            ),
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                // Avatar
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.inverseSurface, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(Icons.person, size: 64, color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 32),
                // Identity
                Text(
                  'Customer',
                  style: textTheme.displaySmall?.copyWith(
                    color: colorScheme.onInverseSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Privacy Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock, size: 16, color: colorScheme.onInverseSurface.withOpacity(0.7)),
                      const SizedBox(width: 8),
                      Text(
                        'MASKED FOR PRIVACY',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onInverseSurface.withOpacity(0.7),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Timer
                Text(
                  '02:45',
                  style: textTheme.displayMedium?.copyWith(
                    color: colorScheme.onInverseSurface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ongoing Call',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onInverseSurface.withOpacity(0.7),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
            // Bottom Utility Buttons
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildUtilityButton(context, Icons.mic),
                      const SizedBox(width: 24),
                      _buildEndCallButton(context),
                      const SizedBox(width: 24),
                      _buildUtilityButton(context, Icons.volume_up),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUtilityButton(BuildContext context, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: colorScheme.onSurface),
        onPressed: () {},
      ),
    );
  }

  Widget _buildEndCallButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: colorScheme.error,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.error.withOpacity(0.4),
            blurRadius: 20,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.call_end, size: 36, color: colorScheme.onError),
        onPressed: () {},
      ),
    );
  }
}
