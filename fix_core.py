import os
import re

color_map = {
    r'const Color\(0xFFFBF8FF\)': 'Theme.of(context).colorScheme.surface',
    r'Color\(0xFFFFDAD6\)': 'Theme.of(context).colorScheme.errorContainer',
    r'Color\(0xFFBA1A1A\)': 'Theme.of(context).colorScheme.error',
    r'Color\(0xFF1A1B23\)': 'Theme.of(context).colorScheme.onSurface',
    r'Color\(0xFF434654\)': 'Theme.of(context).colorScheme.onSurfaceVariant',
    r'const Color\(0xFF002B92\)': 'Theme.of(context).colorScheme.primary',
    r'const Color\(0xFFFFFFFF\)': 'Theme.of(context).colorScheme.onPrimary',
}

filepath = 'lib/core/error/view/system_error_screen.dart'
with open(filepath, 'r') as f:
    content = f.read()

content = content.replace('backgroundColor: const Color(0xFFFBF8FF),', 'backgroundColor: Theme.of(context).colorScheme.surface,')
content = content.replace('const BoxDecoration(', 'BoxDecoration(')
content = content.replace('const Center(', 'Center(')
content = content.replace('const Icon(', 'Icon(')
content = content.replace('const Text(', 'Text(')

for pattern, replacement in color_map.items():
    content = re.sub(pattern, replacement, content)

with open(filepath, 'w') as f:
    f.write(content)

print("Done fixing core.")
