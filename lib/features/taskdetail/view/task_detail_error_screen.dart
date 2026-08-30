import 'package:flutter/material.dart';

class TaskDetailErrorScreen extends StatelessWidget {
  const TaskDetailErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurfaceVariant),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'Task Detail',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 48,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Connection Error',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Failed to load task details. Please check your connection and try again.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  minimumSize: const Size(160, 48),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                icon: const Icon(Icons.refresh, size: 20),
                label: const Text('Retry', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 48), // Bottom offset
            ],
          ),
        ),
      ),
    );
  }
}
