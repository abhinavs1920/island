import 'package:flutter/material.dart';

class ErrorIconContainer extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final double containerSize;

  const ErrorIconContainer({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.iconSize = 48.0,
    this.containerSize = 96.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}

class ErrorPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ErrorPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class ErrorSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? foregroundColor;

  const ErrorSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 48.0,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor ?? theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
