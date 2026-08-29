import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/secure_storage.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Text(
          'TaskRunner',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          profileAsync.maybeWhen(
            data: (profile) => Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: profile.isAvailable ? Theme.of(context).colorScheme.surfaceVariant : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    profile.isAvailable ? 'Online' : 'Offline',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: profile.isAvailable ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) => _buildBody(context, ref, profile),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: TextStyle(color: Theme.of(context).colorScheme.error)),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, ProfileState profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.surfaceVariant),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      child: Icon(Icons.person, size: 48, color: Colors.grey.shade400),
                    ),
                    if (profile.isAvailable)
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary, size: 24),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  profile.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '4.8 Rating',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('•', style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                    ),
                    Text(
                      '124 Gigs Completed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Earnings Summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary, // Using primary for 0xFF0052FF
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance_wallet, color: Theme.of(context).colorScheme.onPrimary),
                      const SizedBox(height: 4),
                      Text(
                        'This Week',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${profile.earnings.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
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
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).colorScheme.surfaceVariant), // or outlineVariant
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 4),
                      Text(
                        'Response Rate',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '98%',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.surfaceVariant),
            ),
            child: Column(
              children: [
                _buildListTile(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () => context.push('/settings'),
                ),
                Divider(height: 1, color: Theme.of(context).colorScheme.surfaceVariant),
                _buildListTile(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help/Support',
                  onTap: () {},
                ),
                Divider(height: 1, color: Theme.of(context).colorScheme.surfaceVariant),
                _buildListTile(
                  context,
                  icon: Icons.logout,
                  title: 'Log out',
                  isDestructive: true,
                  onTap: () async {
                    await ref.read(storageServiceProvider).clearTokens();
                    if (context.mounted) {
                      context.go('/phone');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isDestructive ? FontWeight.w700 : FontWeight.w400,
                  color: isDestructive ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            if (!isDestructive)
              Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.outline),
          ],
        ),
      ),
    );
  }
}
