import re

for i in range(1, 8):
    file_path = f"/home/abxh/island/tmp_html/{i}.html"
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Remove script and style
    content = re.sub(r'<script.*?>.*?</script>', '', content, flags=re.DOTALL)
    content = re.sub(r'<style.*?>.*?</style>', '', content, flags=re.DOTALL)
    
    # Get body
    body_match = re.search(r'<body.*?>(.*?)</body>', content, flags=re.DOTALL)
    if body_match:
        body = body_match.group(1)
        # Extract text from tags
        text = re.sub(r'<[^>]+>', '\n', body)
        lines = [line.strip() for line in text.split('\n') if line.strip()]
        
        print(f"\n--- {file_path} ---")
        for line in lines[:100]:
            print(line)

