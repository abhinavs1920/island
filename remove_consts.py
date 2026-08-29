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
        text = file.read()
    
    # Remove all `const ` before widgets
    widgets = ['BoxDecoration', 'TextStyle', 'Icon', 'Text', 'Row', 'Column', 'Container', 'Border', 'BorderSide', 'BoxShadow', 'Center', 'Expanded', 'Padding', 'Positioned', 'Stack', 'SizedBox', 'ElevatedButton', 'TextButton', 'Divider', 'CircularProgressIndicator', 'NetworkImage', 'DecorationImage', 'LinearGradient', 'SnackBar', r'\[', '<Widget>\[']
    
    for w in widgets:
        text = re.sub(r'const\s+' + w, w, text)
        
    with open(f, 'w') as file:
        file.write(text)

