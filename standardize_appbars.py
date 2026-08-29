import os
import re

def standardize_appbars():
    for root, dirs, files in os.walk('lib'):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r') as f:
                    content = f.read()
                
                original = content
                
                # Replace 'TaskRunner' with 'Flikk'
                content = content.replace("'TaskRunner'", "'Flikk'")
                content = content.replace('"TaskRunner"', "'Flikk'")
                
                # Remove redundant AppBar styling
                content = re.sub(r'backgroundColor:\s*Theme\.of\(context\)\.colorScheme\.surface,\s*', '', content)
                content = re.sub(r'elevation:\s*0,?\s*', '', content)
                
                # Replace manual back buttons that just pop
                manual_leading_pattern = r'leading:\s*IconButton\(\s*(?:icon:\s*Icon\(Icons\.arrow_back[^)]*\),\s*)?(?:onPressed:\s*\(\)\s*(?:=>|\{)[^}]*(?:context\.pop\(\)|Navigator\.maybePop\(context\)|Navigator\.pop\(context\))[^}]*(?:\}|;)\s*,?\s*)?(?:icon:\s*Icon\(Icons\.arrow_back[^)]*\),?\s*)?\),'
                content = re.sub(manual_leading_pattern, '', content)
                
                # Simplify Text styling for 'Flikk' title
                # Regex matches: title: Text('Flikk', style: ... )
                # Note: This is a bit tricky to match perfectly with regex if there are nested parentheses.
                # Since we know the exact codebase, we can do direct replacements.
                
                if content != original:
                    with open(filepath, 'w') as f:
                        f.write(content)
                    print(f"Standardized {filepath}")

if __name__ == '__main__':
    standardize_appbars()
