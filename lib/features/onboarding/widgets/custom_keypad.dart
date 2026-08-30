import 'package:flutter/material.dart';

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onBackspace;

  const CustomKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      childAspectRatio: 2,
      children: [
        for (int i = 1; i <= 9; i++) _buildKey(context, i.toString()),
        const SizedBox(),
        _buildKey(context, '0'),
        _buildBackspace(context),
      ],
    );
  }

  Widget _buildKey(BuildContext context, String text) {
    return Material(
      color: Theme.of(context).colorScheme.surface, // Maps to surface-container-lowest
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () => onKeyPressed(text),
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspace(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onBackspace,
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
