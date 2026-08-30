import 'package:flutter/material.dart';
import '../widgets/error_components.dart';

class SystemErrorFallbackScreen extends StatelessWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onContactSupport;

  const SystemErrorFallbackScreen({
    super.key,
    this.onRetry,
    this.onContactSupport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
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
                    icon: Icons.error_outline,
                    backgroundColor: theme.colorScheme.errorContainer,
                    iconColor: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Something went wrong',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onBackground,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We couldn\'t process your request. Please check your connection and try again.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 384),
                    child: ErrorPrimaryButton(
                      label: 'Retry',
                      onPressed: onRetry ?? () {},
                    ),
                  ),
                  const SizedBox(height: 24),
                  ErrorSecondaryButton(
                    label: 'Contact Support',
                    onPressed: onContactSupport ?? () {},
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
