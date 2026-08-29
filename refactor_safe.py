import re
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
    "0xFFE1E1EF": "surfaceVariant",
    "0xFFE2E1ED": "surfaceVariant",
    "0xFFFFFFFF": "surface",
    "0xFFE7E7F5": "surfaceContainerHigh",
    "0xFFDFE3FF": "onPrimaryContainer",
    "0xFFEDEDFB": "surfaceContainer",
}

for f in files:
    if not os.path.exists(f): continue
    with open(f, "r") as file:
        content = file.read()
    
    # Replace colors
    for hex_code, theme_color in color_map.items():
        content = re.sub(r'const\s+Color\(' + hex_code + r'\)', f'Theme.of(context).colorScheme.{theme_color}', content)
        content = re.sub(r'Color\(' + hex_code + r'\)', f'Theme.of(context).colorScheme.{theme_color}', content)

    # Remove Scaffold backgroundColor if surface
    content = re.sub(r'backgroundColor:\s*Theme\.of\(context\)\.colorScheme\.surface,\s*// surface\n', '', content)
    content = re.sub(r'backgroundColor:\s*Theme\.of\(context\)\.colorScheme\.surface,\n', '', content)

    # Fix TextStyles manually instead of regex, or use safe regex
    # displayLarge
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*32,\s*fontWeight:\s*FontWeight\.w800,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.displayLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*32,\s*fontWeight:\s*FontWeight\.w800,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.displayLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    # headlineLarge
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*24,\s*fontWeight:\s*FontWeight\.w700,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*24,\s*fontWeight:\s*FontWeight\.w700,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    # titleLarge
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*20,\s*fontWeight:\s*FontWeight\.w700,\s*(?:fontFamily:\s*\'[^\']+\',\s*)?height:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*20,\s*fontWeight:\s*FontWeight\.w700,\s*(?:fontFamily:\s*\'[^\']+\',\s*)?height:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*20,\s*fontWeight:\s*FontWeight\.w700(?:,\s*fontFamily:\s*\'[^\']+\')?,?\s*\)', r'Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*20,\s*fontWeight:\s*FontWeight\.w700(?:,\s*fontFamily:\s*\'[^\']+\')?,?\s*\)', r'Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    # labelLarge
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w700,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w700,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    content = re.sub(r'const\s+TextStyle\(\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w700,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.labelLarge!', content)
    content = re.sub(r'TextStyle\(\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w700,\s*letterSpacing:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.labelLarge!', content)
    
    # labelLarge alternate
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w500,?\s*\)', r'Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w500,?\s*\)', r'Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    # bodyMedium
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*16,\s*height:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*16,\s*height:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*16,?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*fontSize:\s*16,?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    content = re.sub(r'const\s+TextStyle\(\s*fontSize:\s*16,\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*height:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*fontSize:\s*16,\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),\s*height:\s*[-.0-9]+,?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    
    # 18 w700 is not in standard, maybe leave as is or map to something? Let's map to copyWith or leave it alone. The prompt didn't say 18 w700. I'll just let Theme.of(context).colorScheme replace the color.
    
    # General missing colors in TextStyle
    content = re.sub(r'const\s+TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)
    content = re.sub(r'TextStyle\(\s*color:\s*Theme\.of\(context\)\.colorScheme\.([a-zA-Z]+),?\s*\)', r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.\1)', content)

    # Now remove `const ` for lines that have Theme.of(context)
    lines = content.split('\n')
    for i, line in enumerate(lines):
        if 'Theme.of(context)' in line:
            lines[i] = re.sub(r'\bconst\s+', '', line)
    content = '\n'.join(lines)
    
    # The previous loop handles inline consts, but what about multiline const lists?
    # `children: const [` -> `children: [`
    # `boxShadow: const [` -> `boxShadow: [`
    # `const BoxDecoration(` -> `BoxDecoration(`
    # This might remove consts where it shouldn't, but doing it globally is safe for Flutter since const is optional, although it affects performance.
    # We will ONLY remove const if there's Theme.of(context) in the block.
    # To be safe, just remove `const` from `children: const [`
    content = re.sub(r'children:\s*const\s*\[', 'children: [', content)
    content = re.sub(r'boxShadow:\s*const\s*\[', 'boxShadow: [', content)
    
    with open(f, "w") as file:
        file.write(content)

