import 'package:flutter/material.dart';

class DocPendingScreen extends StatelessWidget {
  const DocPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    // In actual app these colors would come from theme extension, hardcoding for now if missing
    final infoBg = const Color(0xFFDBEAFE);
    final infoBlue = const Color(0xFF1E40AF);
    final warningBg = const Color(0xFFFEE2E2);
    final warningRed = const Color(0xFF991B1B);

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: infoBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.schedule,
                    size: 48,
                    color: infoBlue,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Documents Under Review',
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'We are currently verifying your information. This usually takes 24-48 hours.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SUBMITTED DOCUMENTS',
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.secondary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildDocItem(context, Icons.badge_outlined, 'Driver License', warningBg, warningRed),
              const SizedBox(height: 4),
              _buildDocItem(context, Icons.directions_car_outlined, 'Vehicle Registration', warningBg, warningRed),
              const SizedBox(height: 4),
              _buildDocItem(context, Icons.account_circle_outlined, 'Profile Photo', warningBg, warningRed),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  child: Text(
                    'Done',
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
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

  Widget _buildDocItem(BuildContext context, IconData icon, String title, Color warningBg, Color warningRed) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.outline),
              const SizedBox(width: 16),
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onBackground,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: warningBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: warningRed.withOpacity(0.2)),
            ),
            child: Text(
              'Pending',
              style: textTheme.labelMedium?.copyWith(
                color: warningRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
