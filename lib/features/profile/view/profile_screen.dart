import '../../home/providers/home_controller.dart';
import '../providers/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  String _formatJoinedDate(DateTime? date) {
    if (date == null) return 'Joined March 2026';
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final monthName = (date.month >= 1 && date.month <= 12) ? months[date.month - 1] : '';
    return 'Joined $monthName ${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Rider Profile'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                ref.watch(isOnlineProvider) ? 'Online' : 'Offline',
                style: textTheme.labelLarge?.copyWith(
                  color: ref.watch(isOnlineProvider) ? Colors.green : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) => _buildProfileContent(context, profile),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _buildProfileContent(
          context,
          ProfileState(
            id: 'mock',
            name: 'Rajesh K.',
            phone: '+919876543210',
            isAvailable: true,
            earnings: 450.0,
            completedGigs: 124,
            failedTasks: 2,
            joinedDate: DateTime(2026, 3, 1),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileState profile) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Header
          Container(
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surfaceContainerHighest,
                          width: 4,
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCDttZs56DXc3pz1S6U2BUxBkkK3zKu0_XCfso3HEAbLYM0pM7Jk-3xzCyHvWqk4tUXbazC2TRqYu95XklxSb8CRd8MY7RPwt7CKVAsYe7mUCMzVzymtX672qvdWHYjXy92wOX57bmURdJHrW_n-bpy7liDjWgkP3oN2TGqEgmzi7oaioH1ck0JnGRCsDK7ZICzYoLmbguyOa-_Psaka4CfZazBy0swF3-2bWHEL877VmHxN0z1QXjd'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  profile.name,
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text(
                      _formatJoinedDate(profile.joinedDate),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Updated Stats Cards (Gigs Completed, Tasks Failed, Total Earnings)
          Row(
            children: [
              // Gigs Completed Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.green, size: 24),
                      const SizedBox(height: 8),
                      Text(
                        'Completed',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${profile.completedGigs}',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Tasks Failed Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cancel_outlined, color: colorScheme.error, size: 24),
                      const SizedBox(height: 8),
                      Text(
                        'Tasks Failed',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${profile.failedTasks}',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Earnings Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined, color: colorScheme.onPrimaryContainer, size: 24),
                      const SizedBox(height: 8),
                      Text(
                        'Earnings',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${profile.earnings.toInt()}',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Menu Actions List
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.description_outlined, color: colorScheme.secondary),
                  title: const Text('My Documents'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/profile/documents'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.star_outline, color: colorScheme.secondary),
                  title: const Text('Ratings & Reviews'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/profile/ratings'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.settings_outlined, color: colorScheme.secondary),
                  title: const Text('Settings'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/settings/settings'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.help_outline, color: colorScheme.secondary),
                  title: const Text('Help & Support'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/support/help-center'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.logout, color: colorScheme.error),
                  title: Text(
                    'Log out',
                    style: TextStyle(
                      color: colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => context.push('/misc/logout-confirmation-dialog'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
