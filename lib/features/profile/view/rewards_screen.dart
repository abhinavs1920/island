import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Rewards & Achievements',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Points Header Section
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Container(
                    height: 4,
                    color: colorScheme.primary,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      children: [
                        Icon(Icons.stars, color: colorScheme.primary, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          '1,250 pts',
                          style: textTheme.headlineMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total Lifetime Points',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info, color: Color(0xFF1E40AF)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Earn more points by completing high-priority tasks and maintaining top ratings.',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Achievements Section
            Text(
              'Achievements',
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildAchievementBadge(
                  context,
                  title: 'First Delivery',
                  status: 'Unlocked',
                  icon: Icons.pedal_bike,
                  color: Colors.green,
                  bgColor: Colors.green.withOpacity(0.1),
                  isLocked: false,
                ),
                _buildAchievementBadge(
                  context,
                  title: 'Speed Demon',
                  status: 'Unlocked',
                  icon: Icons.speed,
                  color: colorScheme.primary,
                  bgColor: colorScheme.primaryContainer.withOpacity(0.3),
                  isLocked: false,
                ),
                _buildAchievementBadge(
                  context,
                  title: '10 Trips',
                  status: 'Unlocked',
                  icon: Icons.local_shipping,
                  color: const Color(0xFF1E40AF),
                  bgColor: const Color(0xFFDBEAFE),
                  isLocked: false,
                ),
                _buildAchievementBadge(
                  context,
                  title: 'Top Rated',
                  status: 'Locked',
                  icon: Icons.workspace_premium,
                  color: colorScheme.secondary,
                  bgColor: colorScheme.surfaceContainerHighest,
                  isLocked: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementBadge(
    BuildContext context, {
    required String title,
    required String status,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required bool isLocked,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: isLocked ? colorScheme.surfaceContainerHighest.withOpacity(0.5) : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicWidth(
        child: Row(
          children: [
            if (!isLocked)
              Container(
                width: 4,
                color: color,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 32),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: textTheme.labelSmall?.copyWith(
                        color: isLocked ? colorScheme.secondary : color,
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
