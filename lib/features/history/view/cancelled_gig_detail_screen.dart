import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CancelledGigDetailScreen extends StatelessWidget {
  const CancelledGigDetailScreen({Key? key}) : super(key: key);

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
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: Text(
          'Gig Detail',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20).copyWith(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Hero
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.error),
              ),
              child: Row(
                children: [
                  Icon(Icons.cancel, color: colorScheme.error),
                  const SizedBox(width: 8),
                  Text(
                    'Cancelled',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Gig Info Card
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('AC Repair', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 18, color: colorScheme.onSurfaceVariant),
                                const SizedBox(width: 4),
                                Text('Indiranagar', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, size: 18, color: colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text('Jun 15, 2023, 11:30 AM', style: textTheme.bodyMedium),
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
            ),
            const SizedBox(height: 16),

            // Location
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PICKUP ADDRESS',
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        child: Icon(Icons.my_location_outlined, color: colorScheme.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '123 Tech Park, 4th Cross, Indiranagar, Bangalore',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCXwCIzpU_zzL48AZ7PzYAzKjbWnZoBG3-1UjS-hnL07kbOhgYCj5sZ7vqeAtcWCQtaVR_uJaVE87kgSFGBjebI-J0aBCLaI9sJ88D_5g8hfFgk5DTKvW5P2qKF0r7x-bbM-agmgFGrdVLkHj89JITntwj2fbPn1xVIBjMkpn9cWf4g6bme9WSsViNLpb2g5rcsFEGWXuh8MveNukgwbdUZKmSvdQ1BFkdoCkLC3KAwM5Ed0EZwCaKDZTSZy6CZF4r1AltqIoMPJ1E',
                      height: 128,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Cancellation Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, color: Colors.red.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reason', style: textTheme.titleSmall?.copyWith(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Cancelled by Rider', style: textTheme.bodyMedium?.copyWith(color: Colors.red.shade900)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.red.shade200),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancellation Fee', style: textTheme.titleSmall?.copyWith(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
                      Text('\$5.00', style: textTheme.titleLarge?.copyWith(color: colorScheme.error, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DESCRIPTION',
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Request for AC service. The rider was unable to reach the location due to vehicle issues.',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, -4), blurRadius: 6),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: colorScheme.primary, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Raise a Dispute',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Contact Support',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
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
