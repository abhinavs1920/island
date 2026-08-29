import re
import os

files = [
    "lib/features/task_detail/view/task_detail_screen.dart",
    "lib/features/task_detail/view/matched_confirmation_screen.dart",
    "lib/features/task_detail/view/race_lost_screen.dart",
    "lib/features/task_action/view/complete_task_sheet.dart",
    "lib/features/task_action/view/cancel_task_sheet.dart",
]

def remove_const(text):
    # Remove const before common widgets/collections
    patterns = [
        r'const\s+Text\(',
        r'const\s+Icon\(',
        r'const\s+TextStyle\(',
        r'const\s+BoxDecoration\(',
        r'const\s+BorderSide\(',
        r'const\s+Border\(',
        r'const\s+BoxShadow\(',
        r'const\s+Center\(',
        r'const\s+SizedBox\(',
        r'const\s+Padding\(',
        r'const\s+Row\(',
        r'const\s+Column\(',
        r'const\s+Stack\(',
        r'const\s+Positioned\(',
        r'const\s+Expanded\(',
        r'const\s+Container\(',
        r'const\s+DecorationImage\(',
        r'const\s+NetworkImage\(',
        r'children:\s*const\s*\[',
        r'boxShadow:\s*const\s*\[',
    ]
    for p in patterns:
        # replace all for simplicity. If a widget doesn't need to be const, it's fine.
        # But wait, removing `const` globally might cause warnings, but it will compile.
        text = re.sub(p, lambda m: m.group(0).replace('const ', ''), text)
    return text

def apply_textstyles(text):
    # displayLarge: 32 w800
    text = re.sub(
        r'TextStyle\(\s*color:\s*([^,]+),\s*fontSize:\s*32,\s*fontWeight:\s*FontWeight\.w800(?:,\s*letterSpacing:\s*[^,]+)?\s*\)',
        r'Theme.of(context).textTheme.displayLarge!.copyWith(color: \1)', text)

    # headlineLarge: 24 w700
    text = re.sub(
        r'TextStyle\(\s*color:\s*([^,]+),\s*fontSize:\s*24,\s*fontWeight:\s*FontWeight\.w700(?:,\s*letterSpacing:\s*[^,]+)?\s*\)',
        r'Theme.of(context).textTheme.headlineLarge!.copyWith(color: \1)', text)
    
    # titleLarge: 20 w700
    # Could have family Inter, letter spacing etc.
    text = re.sub(
        r'TextStyle\(\s*color:\s*([^,]+),\s*fontSize:\s*20,\s*fontWeight:\s*FontWeight\.w700(?:,[^)]+)?\s*\)',
        r'Theme.of(context).textTheme.titleLarge!.copyWith(color: \1)', text)
    
    # labelLarge: 14 w700
    text = re.sub(
        r'TextStyle\(\s*color:\s*([^,]+),\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w700(?:,[^)]+)?\s*\)',
        r'Theme.of(context).textTheme.labelLarge!.copyWith(color: \1)', text)
    text = re.sub(
        r'TextStyle\(\s*fontSize:\s*14,\s*fontWeight:\s*FontWeight\.w700,\s*letterSpacing:\s*[^,]+(?:,[^)]+)?\s*\)',
        r'Theme.of(context).textTheme.labelLarge!', text)

    # bodyMedium: 16
    text = re.sub(
        r'TextStyle\(\s*color:\s*([^,]+),\s*fontSize:\s*16(?:,\s*height:\s*[^,]+)?\s*\)',
        r'Theme.of(context).textTheme.bodyMedium!.copyWith(color: \1)', text)

    # Some might not have color in the first param, or might not have color
    text = re.sub(
        r'TextStyle\(\s*fontSize:\s*14,\s*color:\s*([^,]+)\s*\)',
        r'Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14, color: \1)', text) # just mapping generic

    return text

for f in files:
    if not os.path.exists(f): continue
    with open(f, "r") as file:
        content = file.read()
    
    content = remove_const(content)
    content = apply_textstyles(content)
    
    with open(f, "w") as file:
        file.write(content)

