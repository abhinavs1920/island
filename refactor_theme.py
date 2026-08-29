import re
import sys
import os

files = [
    "lib/features/task_detail/view/task_detail_screen.dart",
    "lib/features/task_detail/view/matched_confirmation_screen.dart",
    "lib/features/task_detail/view/race_lost_screen.dart",
    "lib/features/task_action/view/complete_task_sheet.dart",
    "lib/features/task_action/view/cancel_task_sheet.dart",
]

color_map = {
    "0xFF003EC7": "primary",
    "0xFF0052FF": "primaryContainer",
    "0xFFFBF8FF": "surface",
    "0xFF191B25": "onSurface",
    "0xFF434656": "onSurfaceVariant",
    "0xFF737688": "outline",
    "0xFFC3C5D9": "outlineVariant",
    "0xFFBA1A1A": "error",
    "0xFFFFDAD6": "errorContainer",
    "0xFF93000A": "onErrorContainer",
    "0xFFE1E1EF": "surfaceVariant", # assumed
    "0xFFE2E1ED": "surfaceVariant", # assumed
    "0xFFFFFFFF": "surface", # assumed
    "0xFFE7E7F5": "surfaceContainerHigh",
    "0xFFDFE3FF": "onPrimaryContainer",
    "0xFFEDEDFB": "surfaceContainer",
    # Do not replace success greens or star colors unless we know them
}

def replace_colors(text):
    for hex_code, theme_color in color_map.items():
        text = re.sub(r'const\s+Color\(' + hex_code + r'\)', f'Theme.of(context).colorScheme.{theme_color}', text)
        text = re.sub(r'Color\(' + hex_code + r'\)', f'Theme.of(context).colorScheme.{theme_color}', text)
    return text

def fix_consts(text):
    # This is a bit tricky, but we can remove `const` before widgets that now have Theme.of(context)
    # A simple approach is to look for const <Widget>(...Theme.of(context)...)
    # Actually, we can just run a pass to remove const from some common parents.
    
    # Remove const before Text( if it contains Theme.of
    lines = text.split('\n')
    for i in range(len(lines)):
        if 'Theme.of(context)' in lines[i]:
            # remove const from the same line
            lines[i] = re.sub(r'\bconst\s+', '', lines[i])
            # remove const from previous lines if it's just const Widget(
            # This is hard to do with regex perfectly, but let's try a naive approach
    
    text = '\n'.join(lines)
    # We will do a broader regex: replace `const ` with `` if the block contains Theme.of(context)
    return text

for file_path in files:
    if not os.path.exists(file_path):
        continue
    with open(file_path, 'r') as f:
        content = f.read()

    # 1. Remove backgroundColor: const Color(0xFFFBF8FF) from Scaffold
    content = re.sub(r'backgroundColor:\s*const\s+Color\(0xFFFBF8FF\),\s*//[^\n]*\n', '', content)
    content = re.sub(r'backgroundColor:\s*const\s+Color\(0xFFFBF8FF\),\n', '', content)

    # 2. TextStyles
    # fontSize: 32, fontWeight: FontWeight.w800 -> displayLarge
    # fontSize: 24, fontWeight: FontWeight.w700 -> headlineLarge
    # fontSize: 20, fontWeight: FontWeight.w700 -> titleLarge
    # fontSize: 16 -> bodyMedium (default weight)
    # fontSize: 14, fontWeight: FontWeight.w700 -> labelLarge
    
    # We'll do this manually for the provided files since they are small.
    # Actually, let's just do a regex replace for TextStyle(...) to Theme.of(context).textTheme...
    
    # Let's write the modified content back
    content = replace_colors(content)
    
    with open(file_path, 'w') as f:
        f.write(content)

