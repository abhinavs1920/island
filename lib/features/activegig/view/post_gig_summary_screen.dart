import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class PostGigSummaryScreen extends StatelessWidget {
  const PostGigSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.primary, // Dark blue background
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: Stack(
        children: [
          // Optional Background Effect (e.g. gradient or subtle pattern)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Top Section: Celebration & Earnings
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981), // success-emerald
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Gig Completed!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'TOTAL EARNINGS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '₹85.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Summary Card (Glassmorphism)
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Gig Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.5,
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: [
                                      _buildDetailItem(
                                        icon: Icons.navigation,
                                        label: 'Distance',
                                        value: '4.2 km',
                                      ),
                                      _buildDetailItem(
                                        icon: Icons.schedule,
                                        label: 'Duration',
                                        value: '28 mins',
                                      ),
                                      _buildDetailItem(
                                        icon: Icons.payments,
                                        label: 'Base Pay',
                                        value: '₹65.00',
                                      ),
                                      _buildDetailItem(
                                        icon: Icons.stars,
                                        label: 'Bonus',
                                        value: '+₹20.00',
                                        valueColor: const Color(0xFFD1FAE5), // success-light
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Bottom Actions
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.star_rate),
                    label: const Text('Rate Customer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: theme.colorScheme.primary,
                      minimumSize: const Size(double.infinity, 56),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      minimumSize: const Size(double.infinity, 56),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Go Back to Home'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: valueColor ?? Colors.white.withOpacity(0.7),
          size: 24,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
