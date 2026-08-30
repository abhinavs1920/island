import 'package:flutter/material.dart';

class MatchedConfirmationScreen extends StatelessWidget {
  const MatchedConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Decorative Background Element
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 48,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Headline
                  Text(
                    "You're matched!",
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onBackground,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  Text(
                    'Message the requester to confirm details.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Contextual Details Card
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: colorScheme.outlineVariant),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.person, color: colorScheme.primary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alex Johnson',
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Delivery to Downtown',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: colorScheme.outline),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Anchored CTA
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surface.withOpacity(0.0),
                  ],
                ),
              ),
              child: SafeArea(
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.chat),
                  label: const Text('Open chat', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
