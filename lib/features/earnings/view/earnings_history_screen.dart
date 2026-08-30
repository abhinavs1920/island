import 'package:flutter/material.dart';

class EarningsHistoryScreen extends StatefulWidget {
  const EarningsHistoryScreen({super.key});

  @override
  State<EarningsHistoryScreen> createState() => _EarningsHistoryScreenState();
}

class _EarningsHistoryScreenState extends State<EarningsHistoryScreen> {
  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Earnings History',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Filter Segment
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(context, label: 'This Week', index: 0),
                    const SizedBox(width: 8),
                    _buildFilterChip(context, label: 'This Month', index: 1),
                    const SizedBox(width: 8),
                    _buildCustomFilterChip(context),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Summary Section
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL EARNINGS',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$1,240.00',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.trending_up, color: Colors.green.shade600, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '+12% from last week',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.green.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // List Section
              Text(
                'Recent Payouts',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              _buildHistoryItem(
                context,
                date: 'Oct 12, 10:30 AM',
                id: '#8492',
                title: 'Grocery Delivery',
                amount: '+\$15.50',
              ),
              const SizedBox(height: 12),
              _buildHistoryItem(
                context,
                date: 'Oct 11, 2:15 PM',
                id: '#8485',
                title: 'Package Courier',
                amount: '+\$22.00',
              ),
              const SizedBox(height: 12),
              _buildHistoryItem(
                context,
                date: 'Oct 10, 9:00 AM',
                id: '#8470',
                title: 'Heavy Furniture Move',
                amount: '+\$45.00',
                hasWarning: true,
              ),
              const SizedBox(height: 90), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, {required String label, required int index}) {
    final isSelected = _selectedFilterIndex == index;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ActionChip(
      label: Text(label),
      labelStyle: theme.textTheme.labelLarge?.copyWith(
        color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      ),
      backgroundColor: isSelected ? colorScheme.primaryContainer : colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isSelected ? Colors.transparent : colorScheme.outlineVariant,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      onPressed: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
    );
  }

  Widget _buildCustomFilterChip(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ActionChip(
      label: Row(
        children: [
          Text(
            'Custom',
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_drop_down, size: 16, color: colorScheme.onSurfaceVariant),
        ],
      ),
      backgroundColor: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      onPressed: () {
        // Custom filter logic
      },
    );
  }

  Widget _buildHistoryItem(
    BuildContext context, {
    required String date,
    required String id,
    required String title,
    required String amount,
    bool hasWarning = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final indicatorColor = hasWarning ? colorScheme.error : colorScheme.surfaceVariant;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 2,
            offset: const Offset(0, 1),
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
            child: Container(color: indicatorColor),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            date,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              id,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          if (hasWarning) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.warning, size: 14, color: colorScheme.error),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  amount,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
