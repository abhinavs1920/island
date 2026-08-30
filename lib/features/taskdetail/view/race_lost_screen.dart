import 'package:flutter/material.dart';

class RaceLostScreen extends StatelessWidget {
  const RaceLostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Graphic / Icon
                      Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.hourglass_empty,
                          size: 64,
                          color: colorScheme.outline,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Message
                      Text(
                        'This gig was just taken by another rider',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      
                      Text(
                        'It happens fast! There are plenty more gigs waiting for you.',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Action Area
            Container(
              padding: const EdgeInsets.all(20.0),
              color: colorScheme.surface,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('See other gigs nearby', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
