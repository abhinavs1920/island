import 'package:flutter/material.dart';

class RegistrationTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  const RegistrationTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.outline,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: colorScheme.outline)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}
