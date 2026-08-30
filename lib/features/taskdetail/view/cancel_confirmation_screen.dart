import 'package:flutter/material.dart';

class CancelConfirmationScreen extends StatelessWidget {
  const CancelConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Mock Background Content (Chat Screen)
          Opacity(
            opacity: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(child: const SizedBox()),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(right: 64, bottom: 12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Text('Hey, are you still picking up the package?', style: textTheme.bodyMedium),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(left: 64, bottom: 12),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Yes, on my way now.',
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimaryContainer),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Overlay
          Container(
            color: colorScheme.inverseSurface.withOpacity(0.5),
          ),
          
          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2)),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Drag Handle Indicator
                      Container(
                        width: 48,
                        height: 6,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      
                      // Header
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: colorScheme.errorContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.warning, color: colorScheme.onErrorContainer),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Cancel this task?',
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      Text(
                        'This action cannot be undone. Please select a reason if you wish to proceed.',
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 16),
                      
                      // Reason Chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ActionChip(
                            label: const Text('Requester unreachable'),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: colorScheme.outline),
                            ),
                            backgroundColor: colorScheme.surface,
                          ),
                          ActionChip(
                            label: const Text('Changed my mind'),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: colorScheme.outline),
                            ),
                            backgroundColor: colorScheme.surface,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Divider(color: colorScheme.outlineVariant),
                      const SizedBox(height: 16),
                      
                      // Actions
                      FilledButton.icon(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          backgroundColor: colorScheme.error,
                          foregroundColor: colorScheme.onError,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.cancel),
                        label: const Text('Confirm cancel', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          foregroundColor: colorScheme.onSurface,
                        ),
                        child: const Text('Never mind', style: TextStyle(fontWeight: FontWeight.bold)),
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
