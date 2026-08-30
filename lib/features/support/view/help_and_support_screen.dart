
import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          'TaskRunner',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5).withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981), // success-emerald
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Online',
                  style: textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help & Support',
              style: textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers or get in touch with our team.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search help articles...',
                prefixIcon: Icon(Icons.search, color: colorScheme.outline),
                filled: true,
                fillColor: colorScheme.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'TOPICS',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Column(
                children: [
                  _buildTopicItem(
                    context,
                    icon: Icons.payments_outlined,
                    title: 'My Earnings',
                    showBorder: true,
                  ),
                  _buildTopicItem(
                    context,
                    icon: Icons.build_outlined,
                    title: 'Gig Issues',
                    showBorder: true,
                  ),
                  _buildTopicItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'Account & Profile',
                    showBorder: true,
                  ),
                  _buildTopicItem(
                    context,
                    icon: Icons.security_outlined,
                    title: 'Safety',
                    showBorder: true,
                  ),
                  _buildTopicItem(
                    context,
                    icon: Icons.support_agent_outlined,
                    title: 'Contact Us',
                    showBorder: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 80,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need more help?',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Our support team is available 24/7 to assist you.',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.chat),
                                label: const Text('Chat with us'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primaryContainer,
                                  foregroundColor: colorScheme.onPrimaryContainer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.phone),
                                label: const Text('Call us'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: colorScheme.primary,
                                  side: BorderSide(color: colorScheme.outlineVariant),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool showBorder,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)))
            : null,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        title: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.chevron_right, color: colorScheme.outline),
        onTap: () {},
      ),
    );
  }
}
