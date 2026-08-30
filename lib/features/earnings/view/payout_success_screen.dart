import 'package:flutter/material.dart';

class PayoutSuccessScreen extends StatelessWidget {
  const PayoutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Using green colors for success based on HTML
    final successColor = Colors.green.shade600;
    final successLight = Colors.green.shade100;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Success Animation / Icon
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: successLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: successColor.withOpacity(0.2), width: 4),
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Headline
              Text(
                'Payout Initiated!',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Withdrawn Amount
              Text(
                '\$250.00', // Assuming we can keep it as is, or maybe parameterize it later
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Transaction Details Card
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      width: 4,
                      child: Container(color: colorScheme.primary),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0).copyWith(left: 24.0 + 8.0),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            context,
                            icon: Icons.account_balance,
                            label: 'Destination',
                            value: 'Chase Bank ending in •••• 4821',
                          ),
                          const Divider(height: 24),
                          _buildDetailRow(
                            context,
                            icon: Icons.schedule,
                            label: 'Estimated Arrival',
                            value: '1-2 business days',
                            isValueBold: true,
                          ),
                          const Divider(height: 24),
                          _buildDetailRow(
                            context,
                            icon: Icons.receipt_long,
                            label: 'Reference ID',
                            value: 'TXN-8472-A9F',
                            isMono: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Primary Action
              FilledButton(
                onPressed: () {
                  // Navigation will be handled by GoRouter
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  minimumSize: const Size.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Back to Earnings',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Help Link
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.help_outline, size: 16, color: colorScheme.primary),
                label: Text(
                  'Need help with this transfer?',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isValueBold = false,
    bool isMono = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Row(
      children: [
        Icon(icon, color: colorScheme.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: isValueBold ? FontWeight.w500 : FontWeight.normal,
                  fontFamily: isMono ? 'monospace' : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
