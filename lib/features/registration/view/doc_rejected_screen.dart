import 'package:flutter/material.dart';

class DocRejectedScreen extends StatelessWidget {
  const DocRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    final successEmerald = const Color(0xFF10B981);
    final successLight = const Color(0xFFD1FAE5);

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 1,
        scrolledUnderElevation: 1,
        shadowColor: colorScheme.outlineVariant,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: colorScheme.primary,
          onPressed: () {},
        ),
        title: Text(
          'TaskRunner',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Online',
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.cancel,
                  size: 48,
                  color: colorScheme.error,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Documents Rejected',
              textAlign: TextAlign.center,
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Please review and re-upload the documents below to continue your registration.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            _buildRejectedItem(
              context: context,
              icon: Icons.badge,
              title: "Driver's License",
              errorText: "Image too blurry. Ensure all text is readable and edges are visible.",
            ),
            const SizedBox(height: 16),
            _buildRejectedItem(
              context: context,
              icon: Icons.directions_car,
              title: "Vehicle Insurance",
              errorText: "Document expired. Please upload a policy valid for the current month.",
            ),
            const SizedBox(height: 16),
            _buildApprovedItem(
              context: context,
              icon: Icons.person,
              title: "Profile Photo",
              successColor: successEmerald,
              successBgColor: successLight,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(color: colorScheme.outlineVariant),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onPrimaryContainer,
                  ),
                  icon: const Icon(Icons.upload_file),
                  label: Text(
                    'Re-upload Documents',
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Contact Support',
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
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

  Widget _buildRejectedItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String errorText,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 4,
            child: Container(color: colorScheme.error),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: colorScheme.error),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: colorScheme.error,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Failed',
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.onError,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        errorText,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovedItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color successColor,
    required Color successBgColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Opacity(
      opacity: 0.6,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(color: successColor),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: successBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: successColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.check_circle, size: 16, color: successColor),
                            const SizedBox(width: 4),
                            Text(
                              'Approved',
                              style: textTheme.labelSmall?.copyWith(
                                color: successColor,
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
}
