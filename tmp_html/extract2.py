import re
import sys
import html

for i in range(1, 8):
    file_path = f"/home/abxh/island/tmp_html/{i}.html"
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Simple regex to strip tags but keep order
    text = re.sub(r'<[^>]+>', '\n', content)
    lines = [html.unescape(line.strip()) for line in text.split('\n') if line.strip()]
    
    print(f"\n--- {file_path} ---")
    for line in lines[:20]:
        if "{" not in line and "}" not in line and "var " not in line and "function" not in line:
            print(line)

