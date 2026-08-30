import 'package:flutter/material.dart';

class DailyWeeklyTargetsScreen extends StatelessWidget {
  const DailyWeeklyTargetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Targets',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: colorScheme.primary),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 120.0), // padding for footer
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Daily Target Section
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        width: 4,
                        child: Container(color: colorScheme.primary),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0).copyWith(left: 28.0),
                        child: Column(
                          children: [
                            Text(
                              'DAILY TARGET',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 160,
                              width: 160,
                              child: Stack(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      height: 160,
                                      width: 160,
                                      child: CircularProgressIndicator(
                                        value: 350 / 500,
                                        strokeWidth: 12,
                                        backgroundColor: colorScheme.surfaceVariant,
                                        color: colorScheme.primaryContainer,
                                        strokeCap: StrokeCap.round,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '₹350',
                                          style: theme.textTheme.headlineLarge?.copyWith(
                                            color: colorScheme.onSurface,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          'of ₹500',
                                          style: theme.textTheme.labelMedium?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              '3 more gigs to hit your daily target!',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Weekly Progress Section
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        width: 4,
                        child: Container(color: colorScheme.primary),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0).copyWith(left: 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'WEEKLY EARNINGS',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    '₹1550 Total',
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              height: 160,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildBar(context, label: 'Mon', value: 0.8),
                                  _buildBar(context, label: 'Tue', value: 0.6),
                                  _buildBar(context, label: 'Wed', value: 1.0, isHigh: true),
                                  _buildBar(context, label: 'Thu', value: 0.7, isToday: true),
                                  _buildBar(context, label: 'Fri', value: 0.05, isFuture: true),
                                  _buildBar(context, label: 'Sat', value: 0.05, isFuture: true),
                                  _buildBar(context, label: 'Sun', value: 0.05, isFuture: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Footer Action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surface.withOpacity(0.9),
                    colorScheme.surface.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  minimumSize: const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                icon: const Icon(Icons.bolt),
                label: Text(
                  'Go Online Now',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, {required String label, required double value, bool isToday = false, bool isHigh = false, bool isFuture = false}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isHigh)
            Text(
              'High',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          if (isHigh) const SizedBox(height: 4),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight * value,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isFuture ? colorScheme.surfaceContainerHighest : colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                );
              }
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isToday ? colorScheme.primary : colorScheme.onSurfaceVariant,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
