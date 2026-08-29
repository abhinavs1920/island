import os
import re

color_map = {
    r'const Color\(0xFF10B981\)': 'Theme.of(context).colorScheme.secondary',
    r'Color\(0xFF10B981\)': 'Theme.of(context).colorScheme.secondary',
    r'const Color\(0xFF002B92\)': 'Theme.of(context).colorScheme.primary',
    r'Color\(0xFF002B92\)': 'Theme.of(context).colorScheme.primary',
    r'const Color\(0xFFE2E1ED\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFE2E1ED\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFF3F2FE\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFF3F2FE\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFE8E7F3\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFE8E7F3\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFE1E1E1\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFE1E1E1\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFDBEAFE\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFDBEAFE\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFD1FAE5\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFD1FAE5\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFE8F5E9\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFE8F5E9\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFF5F5F5\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFF5F5F5\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFE7E7F5\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFE7E7F5\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFFC4C5D7\)': 'Theme.of(context).colorScheme.outlineVariant',
    r'Color\(0xFFC4C5D7\)': 'Theme.of(context).colorScheme.outlineVariant',
    r'const Color\(0xFF747686\)': 'Theme.of(context).colorScheme.onSurfaceVariant',
    r'Color\(0xFF747686\)': 'Theme.of(context).colorScheme.onSurfaceVariant',
    r'const Color\(0xFF5F5E5E\)': 'Theme.of(context).colorScheme.onSurfaceVariant',
    r'Color\(0xFF5F5E5E\)': 'Theme.of(context).colorScheme.onSurfaceVariant',
    r'const Color\(0xFF434654\)': 'Theme.of(context).colorScheme.onSurfaceVariant',
    r'Color\(0xFF434654\)': 'Theme.of(context).colorScheme.onSurfaceVariant',
    r'const Color\(0xFF1E40AF\)': 'Theme.of(context).colorScheme.primary',
    r'Color\(0xFF1E40AF\)': 'Theme.of(context).colorScheme.primary',
    r'const Color\(0xFF00875A\)': 'Theme.of(context).colorScheme.secondary',
    r'Color\(0xFF00875A\)': 'Theme.of(context).colorScheme.secondary',
    r'const Color\(0xFFE1E1EF\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'Color\(0xFFE1E1EF\)': 'Theme.of(context).colorScheme.surfaceVariant',
    r'const Color\(0xFF00C853\)': 'Theme.of(context).colorScheme.secondary',
    r'Color\(0xFF00C853\)': 'Theme.of(context).colorScheme.secondary',
    r'const Color\(0xFFBA1A1A\)': 'Theme.of(context).colorScheme.error',
    r'Color\(0xFFBA1A1A\)': 'Theme.of(context).colorScheme.error',
    r'const Color\(0xFF166534\)': 'Theme.of(context).colorScheme.secondary',
    r'Color\(0xFF166534\)': 'Theme.of(context).colorScheme.secondary',
    r'const Color\(0xFF14532D\)': 'Theme.of(context).colorScheme.secondary',
    r'Color\(0xFF14532D\)': 'Theme.of(context).colorScheme.secondary',
}

for root, dirs, files in os.walk('lib/features'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()
            
            original = content
            for pattern, replacement in color_map.items():
                # First remove any leading `const ` from the line if we're replacing something inside it.
                # Actually, simpler: replace `const Icon` with `Icon`, `const Text` with `Text`, etc. if we're changing color
                content = re.sub(pattern, replacement, content)
            
            if content != original:
                with open(filepath, 'w') as f:
                    f.write(content)

print("Done replacing colors.")
