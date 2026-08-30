import 'package:flutter/material.dart';

class RatingsScreen extends StatelessWidget {
  const RatingsScreen({super.key});

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'My Ratings',
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Header Section: Average Rating & Badge
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 160,
                    color: colorScheme.primary,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            '4.8',
                            style: textTheme.displayLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: colorScheme.primaryContainer),
                              Icon(Icons.star, color: colorScheme.primaryContainer),
                              Icon(Icons.star, color: colorScheme.primaryContainer),
                              Icon(Icons.star, color: colorScheme.primaryContainer),
                              Icon(Icons.star_half, color: colorScheme.primaryContainer),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Based on 142 ratings',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.verified,
                                    color: Colors.green, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  'TOP 5% OF RIDERS',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
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
            const SizedBox(height: 8),
            // Breakdown Section: Bar Chart
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating Breakdown',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRatingBar(context, star: 5, percentage: 82),
                  const SizedBox(height: 12),
                  _buildRatingBar(context, star: 4, percentage: 12),
                  const SizedBox(height: 12),
                  _buildRatingBar(context, star: 3, percentage: 4),
                  const SizedBox(height: 12),
                  _buildRatingBar(context, star: 2, percentage: 2),
                  const SizedBox(height: 12),
                  _buildRatingBar(context, star: 1, percentage: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(BuildContext context,
      {required int star, required int percentage}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Row(
            children: [
              Text(
                '$star',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.star, color: colorScheme.outline, size: 16),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 32,
          child: Text(
            '$percentage%',
            textAlign: TextAlign.right,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
