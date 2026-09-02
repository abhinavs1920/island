import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../history/models/gig_model.dart';

enum EarningsTimeFilter {
  today,
  last7Days,
  last30Days,
}

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  EarningsTimeFilter _selectedFilter = EarningsTimeFilter.today;

  final List<GigModel> _allGigs = [
    GigModel(
      id: 'gig_1',
      type: 'Grocery Delivery',
      status: GigStatus.completed,
      amount: 120.0,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      pickupAddress: 'Local Market',
      dropoffAddress: '123 Main St',
    ),
    GigModel(
      id: 'gig_2',
      type: 'AC Repair',
      status: GigStatus.completed,
      amount: 450.0,
      date: DateTime.now().subtract(const Duration(hours: 5)),
      pickupAddress: 'Hardware Store',
      dropoffAddress: '456 Elm St',
    ),
    GigModel(
      id: 'gig_3',
      type: 'Document Courier',
      status: GigStatus.completed,
      amount: 280.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      pickupAddress: 'Tech Park',
      dropoffAddress: 'Central Office',
    ),
    GigModel(
      id: 'gig_4',
      type: 'Furniture Move',
      status: GigStatus.completed,
      amount: 750.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
      pickupAddress: 'IKEA Outlet',
      dropoffAddress: '789 Oak Ave',
    ),
    GigModel(
      id: 'gig_5',
      type: 'Electrical Inspection',
      status: GigStatus.completed,
      amount: 600.0,
      date: DateTime.now().subtract(const Duration(days: 18)),
      pickupAddress: 'City Suburb',
      dropoffAddress: 'Hill View Apt',
    ),
    GigModel(
      id: 'gig_6',
      type: 'Plumbing Fix',
      status: GigStatus.failed,
      amount: 80.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      pickupAddress: 'Station Road',
      dropoffAddress: 'North Enclave',
    ),
  ];

  List<GigModel> _getFilteredGigs() {
    final now = DateTime.now();
    switch (_selectedFilter) {
      case EarningsTimeFilter.today:
        return _allGigs.where((g) {
          return g.date.year == now.year &&
              g.date.month == now.month &&
              g.date.day == now.day;
        }).toList();
      case EarningsTimeFilter.last7Days:
        final threshold = now.subtract(const Duration(days: 7));
        return _allGigs.where((g) => g.date.isAfter(threshold)).toList();
      case EarningsTimeFilter.last30Days:
        final threshold = now.subtract(const Duration(days: 30));
        return _allGigs.where((g) => g.date.isAfter(threshold)).toList();
    }
  }

  double _calculateTotal(List<GigModel> gigs) {
    return gigs
        .where((g) => g.status == GigStatus.completed)
        .fold(0.0, (sum, g) => sum + g.payoutAmount);
  }

  String _getFilterLabel() {
    switch (_selectedFilter) {
      case EarningsTimeFilter.today:
        return "Today's Earnings";
      case EarningsTimeFilter.last7Days:
        return "Last 7 Days Earnings";
      case EarningsTimeFilter.last30Days:
        return "Last 30 Days / Month Earnings";
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredGigs = _getFilteredGigs();
    final totalEarnings = _calculateTotal(filteredGigs);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Earnings'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.outlineVariant, height: 1.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Segmented Filter Bar
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _buildFilterTab('Today', EarningsTimeFilter.today),
                    _buildFilterTab('Last 7 Days', EarningsTimeFilter.last7Days),
                    _buildFilterTab('Last 30 Days', EarningsTimeFilter.last30Days),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Total Earnings Hero Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colorScheme.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      _getFilterLabel(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '₹${totalEarnings.toStringAsFixed(0)}',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${filteredGigs.where((g) => g.status == GigStatus.completed).length} completed gigs in this period',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Breakdown Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gig Breakdown',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.push('/history/gig-history-list'),
                    child: Text(
                      'View All History',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Gigs List
              if (filteredGigs.isEmpty)
                Container(
                  padding: const EdgeInsets.all(32),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.receipt_long_outlined, size: 40, color: colorScheme.onSurfaceVariant),
                      const SizedBox(height: 12),
                      Text(
                        'No gigs in this period',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredGigs.length,
                  itemBuilder: (context, index) {
                    final gig = filteredGigs[index];
                    final isCompleted = gig.status == GigStatus.completed;
                    final isFailed = gig.status == GigStatus.failed;

                    String displayAmount = isCompleted ? '+ ₹${gig.payoutAmount.toInt()}' : '₹0';
                    Color amountColor = isCompleted ? Colors.green : colorScheme.onSurfaceVariant;
                    if (isFailed) {
                      amountColor = colorScheme.error;
                    }

                    String badgeText = isCompleted ? 'Completed' : (gig.status == GigStatus.cancelled ? 'Cancelled' : 'Failed');
                    Color badgeColor = isCompleted ? Colors.green : colorScheme.error;

                    return GestureDetector(
                      onTap: () {
                        if (isCompleted) {
                          context.push('/history/completed-gig-detail', extra: gig.id);
                        } else {
                          context.push('/history/cancelled-gig-detail', extra: gig.id);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colorScheme.outlineVariant),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(width: 4, color: badgeColor),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: colorScheme.surfaceVariant,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isCompleted ? Icons.check_circle : Icons.cancel,
                                          color: badgeColor,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              gig.type,
                                              style: theme.textTheme.titleMedium?.copyWith(
                                                color: colorScheme.onSurface,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              badgeText,
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                color: badgeColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        displayAmount,
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          color: amountColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String label, EarningsTimeFilter filter) {
    final isSelected = _selectedFilter == filter;
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
