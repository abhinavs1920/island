import 'package:flutter/material.dart';

class NotificationToggleItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationToggleItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // surface-lowest
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC4C5D7)), // outline-variant
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left indicator bar
            Container(
              width: 4,
              color: value 
                  ? theme.colorScheme.primary 
                  : const Color(0xFFE8E7F3), // surface-container-high
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 16, 16, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Switch(
                      value: value,
                      onChanged: onChanged,
                      activeColor: Colors.white,
                      activeTrackColor: theme.colorScheme.primary,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFE8E7F3),
                      trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
                        return const Color(0xFFC4C5D7);
                      }),
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
