import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hardcoded to 0.0 for v1
    const double totalEarnings = 0.0;

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
              ),
              child: Column(
                children: [
                  Text(
                    'TOTAL EARNINGS',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '\$${totalEarnings.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
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
            Text(
              'Recent Gigs',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildGigItem(
              context,
              icon: Icons.shopping_cart,
              iconBgColor: Theme.of(context).colorScheme.surfaceVariant,
              iconColor: Theme.of(context).colorScheme.primary,
              title: 'Grocery Delivery',
              date: 'Jun 12, 10:30 AM',
              amount: '+\$15.50',
            ),
            const SizedBox(height: 12),
            _buildGigItem(
              context,
              icon: Icons.local_shipping,
              iconBgColor: Theme.of(context).colorScheme.surfaceVariant,
              iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
              title: 'Furniture Move',
              date: 'Jun 10, 2:15 PM',
              amount: '+\$45.00',
            ),
            const SizedBox(height: 12),
            _buildGigItem(
              context,
              icon: Icons.grass,
              iconBgColor: Theme.of(context).colorScheme.surfaceVariant,
              iconColor: Theme.of(context).colorScheme.secondary,
              title: 'Lawn Mowing',
              date: 'Jun 08, 9:00 AM',
              amount: '+\$30.00',
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All Earnings History',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGigItem(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 4, color: Theme.of(context).colorScheme.primary),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline, // 0xFF5F5E5E maps generally to outline or onSurfaceVariant
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  amount,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
