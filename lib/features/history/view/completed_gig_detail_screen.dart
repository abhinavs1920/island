import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompletedGigDetailScreen extends StatelessWidget {
  final String gigId;

  const CompletedGigDetailScreen({Key? key, this.gigId = '8492'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow.withOpacity(0.2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: Text(
          'Gig Details',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map Thumbnail
            Container(
              height: 192,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
                color: colorScheme.surfaceContainerHighest,
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuD9T90LPfDQYkrop1yOv_VuJZeOiOiXAN991J_qQZKgpB7v4SDa2X4duSlkxc_ihpWbNadDZZ17mLKbT1eeF17dFlLO9YIiq9DWj7e2lJ1_pYJjr655mO3SXEstExqzGKd4i9dWKaxfGvZLoenPFcFMfdDyI4JG61_RDoqBLxZ6Pvj1OXWvO_5cOG9sijuirUf1T8tXvzoeAiO95QfkfWU8MX0R1dZPOYrKb6ROf55gRZdoibOJ41_j78aCzqzdQAp1EKXT_r5hFko',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 48,
                    left: 100,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: colorScheme.primaryContainer,
                        child: Icon(Icons.storefront, size: 16, color: colorScheme.onPrimaryContainer),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 48,
                    right: 100,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.home, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Header Content
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: Colors.green.shade700),
                      const SizedBox(width: 4),
                      Text(
                        'Completed',
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Grocery Delivery #$gigId',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Jun 12, 10:30 AM - 11:15 AM',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),

            // Timeline
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: colorScheme.primaryContainer,
                                  child: Icon(Icons.storefront, size: 14, color: colorScheme.onPrimaryContainer),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Pickup', style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
                                      Text("Trader Joe's, 123 Market St.", style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 11, top: 4, bottom: 4),
                              height: 24,
                              width: 2,
                              color: colorScheme.outlineVariant,
                              alignment: Alignment.centerLeft,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.home, size: 14, color: Colors.white),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Dropoff', style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
                                      Text('Apt 4B, 456 Oak Avenue', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.route, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Distance', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                            Text('4.2 miles', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.schedule, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Duration', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                            Text('45 mins', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Earnings
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EARNINGS BREAKDOWN',
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Base Fare', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                      Text('\$12.50', style: textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bonus/Surge', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                      Text('\$3.00', style: textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Customer Tip', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                      Text('\$5.00', style: textTheme.bodyMedium),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Payout', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        '\$20.50',
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.report),
              label: const Text('Report an Issue'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: colorScheme.outline, width: 2),
                foregroundColor: colorScheme.onSurfaceVariant,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
