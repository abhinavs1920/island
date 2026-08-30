import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? stepText;

  const RegistrationAppBar({
    super.key,
    required this.title,
    this.stepText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: colorScheme.onSurfaceVariant,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
      ),
      centerTitle: true,
      title: stepText == null 
        ? Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
              if (stepText != null) ...[
                const SizedBox(width: 8),
                Text(
                  stepText!,
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ]
            ],
          ),
      actions: [
        if (stepText == null) const SizedBox(width: 48), // spacer
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: colorScheme.outlineVariant,
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
