import 'package:flutter/material.dart';

class SurgeAlertDialog extends StatelessWidget {
  final VoidCallback onGoOnline;
  final VoidCallback onDismiss;

  const SurgeAlertDialog({
    Key? key,
    required this.onGoOnline,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Left Accent Bar
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Map Highlight Area
                Container(
                  height: 200,
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Fake map background
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.8,
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuC2_cv2W6olfjchV_GQ8044pMZaKblDOMSJ4U34FpKlyRdOs0FrQOSi84Ek44PpUpW4ByTILpe4GJK3j0Y46ntUYs0HWnNZrbRVLpAePiUNXWVG9vNVInV6ULNhJ2sTIEv4qMqQmn6eOVkqxOeG2Up8wztIjwS_e0VPeHBLYBnIBlxg5_-KnzM1EoWWKticLpDFoCx3D5RgDs_KP6q6BDfaVvkoftfB82NYgKYw1qsjdYuDAenBABQs1fnhjUU6VBKEBEKnhvpdM60',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const SizedBox(),
                          ),
                        ),
                      ),
                      // Central Marker
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.error.withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.local_fire_department,
                            color: Theme.of(context).colorScheme.onError,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Container
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // 2x Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.bolt,
                              size: 18,
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '2X MULTIPLIER ACTIVE',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onTertiaryContainer,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Surge Zone Active!',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 28,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Earn 2x in this area.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Timer
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ends in',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  '14:59',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Actions
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: onGoOnline,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.power_settings_new),
                          label: const Text('Go Online Now', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: onDismiss,
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Dismiss', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
