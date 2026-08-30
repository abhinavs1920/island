import 'package:flutter/material.dart';

class TaskDetailLoadingScreen extends StatelessWidget {
  const TaskDetailLoadingScreen({super.key});

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
          'TaskRunner',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Online',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 100.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Map Skeleton
                Container(
                  height: 192,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Details Skeleton
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 120, height: 16, color: colorScheme.surfaceContainerHighest),
                          Container(width: 80, height: 24, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(width: 160, height: 24, color: colorScheme.surfaceContainerHighest),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 60, height: 14, color: colorScheme.surfaceContainerHighest),
                                const SizedBox(height: 8),
                                Container(width: 80, height: 20, color: colorScheme.surfaceContainerHighest),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 60, height: 14, color: colorScheme.surfaceContainerHighest),
                                const SizedBox(height: 8),
                                Container(width: 80, height: 20, color: colorScheme.surfaceContainerHighest),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Description Skeleton
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 140, height: 20, color: colorScheme.surfaceContainerHighest),
                      const SizedBox(height: 16),
                      Container(width: double.infinity, height: 16, color: colorScheme.surfaceContainerHighest),
                      const SizedBox(height: 8),
                      Container(width: double.infinity, height: 16, color: colorScheme.surfaceContainerHighest),
                      const SizedBox(height: 8),
                      Container(width: 200, height: 16, color: colorScheme.surfaceContainerHighest),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Action Bar Skeleton
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
              ),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
