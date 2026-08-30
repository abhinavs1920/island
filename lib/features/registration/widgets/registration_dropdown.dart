import 'package:flutter/material.dart';

class RegistrationDropdown<T> extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const RegistrationDropdown({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    required this.items,
    this.value,
    this.onChanged,
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
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          items: items,
          icon: Icon(Icons.expand_more, color: colorScheme.outline),
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: colorScheme.outline) : null,
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
