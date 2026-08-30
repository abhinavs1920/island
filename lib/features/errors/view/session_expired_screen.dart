import 'package:flutter/material.dart';
import '../widgets/error_components.dart';

class SessionExpiredScreen extends StatelessWidget {
  const SessionExpiredScreen({super.key});

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
                    icon: Icons.lock_clock,
                    backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.5), // surface-container-low approx
                    iconColor: theme.colorScheme.onSurfaceVariant,
                    iconSize: 36.0,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Session Expired',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your session expired, please log in again. You will be redirected shortly.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 64,
                    height: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: LinearProgressIndicator(
                        backgroundColor: theme.colorScheme.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary.withOpacity(0.5),
                        ),
                      ),
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
