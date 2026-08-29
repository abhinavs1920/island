import re

with open('lib/features/chat/view/chat_screen.dart', 'r') as f:
    content = f.read()

# Replace messagesAsync.when with if-else logic
when_pattern = re.compile(r'messagesAsync\.when\(\s*data:\s*\(messages\)\s*\{\s*return ListView\.builder\(', re.DOTALL)
if when_pattern.search(content):
    print("Found when pattern!")
else:
    print("When pattern not found")

