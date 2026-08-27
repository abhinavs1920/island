import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hardcoded to 0.0 for v1
    const double totalEarnings = 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF191B25)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Earnings',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF003EC7),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFC3C5D9), height: 1.0),
        ),
      ),
      body: totalEarnings == 0.0
          ? const _EmptyEarningsView()
          : const _EarningsSummaryView(totalEarnings: totalEarnings),
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
                decoration: const BoxDecoration(
                  color: Color(0xFFE8E7F3),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 64,
                    color: Color(0xFF747686),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'No Earnings Yet',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1B23),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Complete your first gig to start earning. Your completed tasks and payments will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Color(0xFF434654),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002B92),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Find Gigs',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC4C5D7)),
              ),
              child: Column(
                children: [
                  const Text(
                    'TOTAL EARNINGS',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5F5E5E),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '\$${totalEarnings.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF002B92),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Earnings shown here are self-reported and may take time to reflect.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF434654),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Recent Gigs',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1B23),
              ),
            ),
            const SizedBox(height: 16),
            _buildGigItem(
              icon: Icons.shopping_cart,
              iconBgColor: const Color(0xFFDBEAFE),
              iconColor: const Color(0xFF1E40AF),
              title: 'Grocery Delivery',
              date: 'Jun 12, 10:30 AM',
              amount: '+\$15.50',
            ),
            const SizedBox(height: 12),
            _buildGigItem(
              icon: Icons.local_shipping,
              iconBgColor: const Color(0xFFE8E7F3),
              iconColor: const Color(0xFF434654),
              title: 'Furniture Move',
              date: 'Jun 10, 2:15 PM',
              amount: '+\$45.00',
            ),
            const SizedBox(height: 12),
            _buildGigItem(
              icon: Icons.grass,
              iconBgColor: const Color(0xFFD1FAE5),
              iconColor: const Color(0xFF10B981),
              title: 'Lawn Mowing',
              date: 'Jun 08, 9:00 AM',
              amount: '+\$30.00',
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All Earnings History',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF002B92),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGigItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC4C5D7)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 4, color: const Color(0xFF002B92)),
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
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1B23),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xFF5F5E5E),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  amount,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF002B92),
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
