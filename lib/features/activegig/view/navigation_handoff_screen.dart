import 'package:flutter/material.dart';

class NavigationHandoffScreen extends StatelessWidget {
  const NavigationHandoffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Background map image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCTLZXyZHTuJlhwF01COyD3WAHFLgLdIZcHYwlF3D2my3VbXmvPOz5iQ78TA02ag4ByD6JMGyA8ugC6ZnxpNzWAWI7OHjvUW9gRfSmW12njKisoai56Om0jikDIEAOIRvRGzEJkjUIf0vLsWLQMeHE6UySWQcCCH71QRMgN_49XFWjBNFwgWjESES3XGnArmtRvJPQPzrmPmeV0TFP1tSCEzQPY-s8vJC0-9kxSDUzf5pYxs3OWWSyMGjO9kyuZK4Z6Fh9lG7jkVs4'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        width: 48,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'NAVIGATE TO',
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.secondary,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '123 Maple Avenue, Suite 4B, Indiranagar',
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Google Maps Button
                          Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                    width: 4,
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.map, size: 32, color: colorScheme.onPrimaryContainer),
                                                  const SizedBox(width: 16),
                                                  Text(
                                                    'Open in Google Maps',
                                                    style: textTheme.bodyLarge?.copyWith(
                                                      color: colorScheme.onPrimaryContainer,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward_ios, size: 20, color: colorScheme.onPrimaryContainer.withOpacity(0.8)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Apple Maps Button
                          Material(
                            color: colorScheme.surfaceContainerLow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: colorScheme.outlineVariant),
                            ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.explore, size: 32, color: colorScheme.primary),
                                        const SizedBox(width: 16),
                                        Text(
                                          'Open in Apple Maps',
                                          style: textTheme.bodyLarge?.copyWith(
                                            color: colorScheme.onSurface,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios, size: 20, color: colorScheme.outline),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Cancel Button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: colorScheme.secondary,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: Text(
                                'Cancel',
                                style: textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
