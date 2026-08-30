import 'package:flutter/material.dart';
import '../widgets/error_components.dart';

class AccountSuspendedScreen extends StatelessWidget {
  final VoidCallback? onContactSupport;
  final VoidCallback? onLearnMore;

  const AccountSuspendedScreen({
    super.key,
    this.onContactSupport,
    this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 672),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ErrorIconContainer(
                    icon: Icons.gpp_bad,
                    backgroundColor: theme.colorScheme.errorContainer,
                    iconColor: theme.colorScheme.onErrorContainer,
                    iconSize: 64.0,
                    containerSize: 112.0, 
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Account Suspended',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your account has been suspended due to a violation of our terms of service or safety guidelines. You will not be able to accept new gigs at this time.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Column(
                      children: [
                        ErrorPrimaryButton(
                          label: 'Contact Support',
                          onPressed: onContactSupport ?? () {},
                          backgroundColor: theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(height: 12),
                        ErrorSecondaryButton(
                          label: 'Learn More',
                          onPressed: onLearnMore ?? () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
