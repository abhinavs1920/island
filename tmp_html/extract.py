import sys
from bs4 import BeautifulSoup
import json

def process(file_path):
    with open(file_path, 'r') as f:
        soup = BeautifulSoup(f.read(), 'html.parser')
    
    # Just extract visible text and some classes for structure
    res = []
    for el in soup.find_all(['h1', 'h2', 'h3', 'p', 'button', 'a', 'span', 'div']):
        if not el.find_all(['h1', 'h2', 'h3', 'p', 'button', 'a', 'span', 'div']):
            text = el.get_text(strip=True)
            if text:
                res.append(f"{el.name}.{'.'.join(el.get('class', []))}: {text}")
    print(f"\n--- {file_path} ---")
    print('\n'.join(res[:50]))

for i in range(1, 8):
    process(f"/home/abxh/island/tmp_html/{i}.html")
