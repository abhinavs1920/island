import re
import os

files = [
    "lib/features/task_detail/view/task_detail_screen.dart",
    "lib/features/task_detail/view/matched_confirmation_screen.dart",
    "lib/features/task_detail/view/race_lost_screen.dart",
    "lib/features/task_action/view/complete_task_sheet.dart",
    "lib/features/task_action/view/cancel_task_sheet.dart",
]

for f in files:
    with open(f, 'r') as file:
        content = file.read()
        
    lines = content.split('\n')
    for i, line in enumerate(lines):
        if 'const [' in line or 'const <' in line or 'const [' in line or 'children: const' in line:
            # this is just heuristic
            print(f"{f}:{i+1}:{line.strip()}")

