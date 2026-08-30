import '../../history/models/gig_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hardcoded to 0.0 for v1
    const double totalEarnings = 850.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Theme.of(context).colorScheme.outlineVariant, height: 1.0),
        ),
      ),
      body: totalEarnings == 0.0
          ? const _EmptyEarningsView()
          : _EarningsSummaryView(totalEarnings: totalEarnings),
    );
  }
}

class _EmptyEarningsView extends StatelessWidget {
  const _EmptyEarningsView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
                const SizedBox(height: 24),
              Text(
                'No Earnings Yet',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Complete your first gig to start earning. Your completed tasks and payments will appear here.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant, // Using onSurfaceVariant instead of hardcoded 0xFF434654
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  ),
                child: Text(
                  'Find Gigs',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EarningsSummaryView extends StatelessWidget {
  final double totalEarnings;

  const _EarningsSummaryView({required this.totalEarnings});

  @override
  Widget build(BuildContext context) {
    final mockRecentGigs = [
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
        status: GigStatus.cancelled,
        amount: 50.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
        pickupAddress: 'Hardware Store',
        dropoffAddress: '456 Elm St',
      ),
      GigModel(
        id: 'gig_3',
        type: 'Furniture Move',
        status: GigStatus.failed,
        amount: 80.0,
        date: DateTime.now().subtract(const Duration(days: 2)),
        pickupAddress: 'IKEA',
        dropoffAddress: '789 Oak Ave',
      ),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Today\'s Earnings',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '₹${totalEarnings.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: const Color(0xFF003ec7), // Primary Blue
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Earnings shown here are self-reported and may take time to reflect.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Gigs',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () => context.push('/history/gig-history-list'),
                  child: Text(
                    'See All',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF003ec7),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockRecentGigs.length,
              itemBuilder: (context, index) {
                final gig = mockRecentGigs[index];
                final isCompleted = gig.status == GigStatus.completed;
                final isCancelled = gig.status == GigStatus.cancelled;
                final isFailed = gig.status == GigStatus.failed;
                
                String displayAmount = isCompleted ? '+ ₹${gig.payoutAmount.toInt()}' : '₹0';
                Color amountColor = isCompleted ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant;
                if (isFailed) {
                  amountColor = Theme.of(context).colorScheme.error;
                }

                String badgeText = isCompleted ? 'Completed' : (isCancelled ? 'Cancelled' : 'Failed');
                Color badgeColor = isCompleted ? Colors.green : Theme.of(context).colorScheme.error;

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
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
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
                                      color: Theme.of(context).colorScheme.surfaceVariant,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isCompleted ? Icons.check_circle : Icons.cancel, 
                                      color: badgeColor, 
                                      size: 20
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          gig.type,
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          badgeText,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: badgeColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    displayAmount,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    );
  }
}
