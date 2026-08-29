import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildListTile(
                context,
                icon: Icons.info,
                title: 'App Version (v1.0.4)',
                onTap: () {},
                showChevron: false,
              ),
              Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
              _buildListTile(
                context,
                icon: Icons.support_agent,
                title: 'Support Contact',
                onTap: () {},
                showChevron: true,
              ),
              Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
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
                showChevron: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool showChevron = false,
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
            if (showChevron)
              Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.outline),
          ],
        ),
      ),
    );
  }
}
