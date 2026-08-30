import 'package:flutter/material.dart';

class SettingsItemButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final bool isError;
  final bool hasTrailing;
  final bool isTopBorderHidden;

  const SettingsItemButton({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.isError = false,
    this.hasTrailing = false,
    this.isTopBorderHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: isError 
            ? theme.colorScheme.errorContainer 
            : theme.colorScheme.surfaceContainerLow,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: const BorderSide(
                color: Color(0xFFC4C5D7), // outline-variant from CSS
              ),
              top: isTopBorderHidden 
                  ? BorderSide.none 
                  : const BorderSide(color: Colors.transparent),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: isError 
                        ? theme.colorScheme.error 
                        : const Color(0xFF5F5E5E), // secondary color
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isError 
                          ? theme.colorScheme.error 
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              if (hasTrailing)
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF5F5E5E),
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
