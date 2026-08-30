import 'package:flutter/material.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all as read'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _NotificationItem(
            isUnread: true,
            icon: Icons.notifications,
            iconColor: theme.colorScheme.primaryContainer,
            iconBackgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.2),
            title: 'New Gig: Furniture Assembly',
            time: '2m ago',
            description: 'A new gig is available in Indiranagar. Earn up to \$45.',
            indicatorColor: theme.colorScheme.primaryContainer,
          ),
          const SizedBox(height: 12),
          _NotificationItem(
            isUnread: false,
            icon: Icons.payments_outlined,
            iconColor: theme.colorScheme.onSurfaceVariant,
            iconBackgroundColor: theme.colorScheme.surfaceContainerHigh,
            title: 'Earnings Credited',
            time: '1h ago',
            description: 'You earned \$30.00 for the Lawn Mowing task.',
            indicatorColor: Colors.transparent,
          ),
          const SizedBox(height: 12),
          _NotificationItem(
            isUnread: true,
            icon: Icons.trending_up,
            iconColor: theme.colorScheme.error,
            iconBackgroundColor: theme.colorScheme.errorContainer,
            title: 'Surge Alert',
            titleColor: theme.colorScheme.error,
            time: '3h ago',
            description: 'High demand in Koramangala. Earn 1.5x on all gigs.',
            indicatorColor: theme.colorScheme.error,
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final bool isUnread;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final Color? titleColor;
  final String time;
  final String description;
  final Color indicatorColor;

  const _NotificationItem({
    required this.isUnread,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    this.titleColor,
    required this.time,
    required this.description,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUnread && indicatorColor == theme.colorScheme.error 
              ? theme.colorScheme.errorContainer 
              : theme.colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              color: indicatorColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: iconBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: titleColor ?? theme.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                time,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: titleColor ?? theme.colorScheme.primaryContainer,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
