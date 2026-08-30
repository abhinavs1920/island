import 'package:flutter/material.dart';
import '../widgets/error_components.dart';

class AppUpdateRequiredScreen extends StatelessWidget {
  final VoidCallback? onUpdateNow;

  const AppUpdateRequiredScreen({
    super.key,
    this.onUpdateNow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 672),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ErrorIconContainer(
                          icon: Icons.system_update,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          iconColor: theme.colorScheme.onPrimaryContainer,
                          iconSize: 48.0,
                          containerSize: 96.0,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Update Required',
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.primary,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'A new version of TaskRunner is available with important improvements and bug fixes. Please update to continue taking gigs.',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48), 
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              color: theme.colorScheme.surface,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 672),
                  child: ErrorPrimaryButton(
                    label: 'Update Now',
                    onPressed: onUpdateNow ?? () {},
                    backgroundColor: theme.colorScheme.primaryContainer,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
