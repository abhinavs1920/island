import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActiveGigInProgressScreen extends StatelessWidget {
  const ActiveGigInProgressScreen({super.key});

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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: colorScheme.primary),
          ),
        ),
        title: Text(
          'DELIVERY PRO',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.sensors, color: colorScheme.primary),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.green.shade600,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Online',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 56,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Map Area
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: colorScheme.surfaceContainerHighest,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCiecrbQjIwRhf_hrAalj7fR6G1kypdhYMPkOGsW02MGUA4c-w6IozKPWsrGyd5MbIMZJTB9crfcaY0qkuKFFqrIK62oJ3erHvwlBDrJlhza0n9kLTaCzZieSYqPa1Zu1tnkP1upqxZeAi-9EigM52O2DjTrYZ5BShVoBd8Xd3-ClBn0U1rLsvL1qwipdLcnZuUE_4os6AQ_Bw0kUOPkdABd484Smj6p4kq0QnuCg3_85SUOVJJsfqJybNWRjXQMjwJ_0GwVdKmdgQ',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: colorScheme.outlineVariant),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Active Task',
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Gig Details Card
          Expanded(
            flex: 4,
            child: Container(
              transform: Matrix4.translationValues(0, -16, 0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 24,
                    bottom: 24,
                    width: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sarah J.',
                                    style: textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.storefront, size: 16, color: colorScheme.onSurfaceVariant),
                                      const SizedBox(width: 4),
                                      Text(
                                        '123 Pine St.',
                                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.home, size: 16, color: colorScheme.onSurfaceVariant),
                                      const SizedBox(width: 4),
                                      Text(
                                        '456 Maple Ave.',
                                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '12 min',
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '2.4 km',
                                  style: textTheme.labelMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primaryContainer,
                                  foregroundColor: colorScheme.onPrimaryContainer,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                icon: const Icon(Icons.chat_bubble),
                                label: const Text('Chat'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  foregroundColor: colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                icon: const Icon(Icons.call),
                                label: const Text('Call'),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: colorScheme.error,
                          ),
                          child: const Text('Cancel Order'),
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_shipping),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments_outlined),
            label: 'Earnings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
