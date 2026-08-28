import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF), // surface
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8FF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF002B92)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF002B92),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFC4C5D7),
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
            border: Border.all(color: const Color(0xFFC4C5D7)),
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
                icon: Icons.info,
                title: 'App Version (v1.0.4)',
                onTap: () {},
                showChevron: false,
              ),
              const Divider(height: 1, color: Color(0xFFC4C5D7)),
              _buildListTile(
                icon: Icons.support_agent,
                title: 'Support Contact',
                onTap: () {},
                showChevron: true,
              ),
              const Divider(height: 1, color: Color(0xFFC4C5D7)),
              _buildListTile(
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

  Widget _buildListTile({
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
              color: isDestructive ? const Color(0xFFBA1A1A) : const Color(0xFF5F5E5E),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isDestructive ? const Color(0xFFBA1A1A) : const Color(0xFF1A1B23),
                ),
              ),
            ),
            if (showChevron)
              const Icon(Icons.chevron_right, color: Color(0xFF5F5E5E)),
          ],
        ),
      ),
    );
  }
}
