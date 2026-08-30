import sys
from html.parser import HTMLParser

class MyHTMLParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.depth = 0
        self.tags = []
        self.classes = []

    def handle_starttag(self, tag, attrs):
        self.depth += 1
        class_name = dict(attrs).get('class', '')
        print('  ' * self.depth + f'<{tag} class="{class_name}">')

    def handle_endtag(self, tag):
        print('  ' * self.depth + f'</{tag}>')
        self.depth -= 1

    def handle_data(self, data):
        data = data.strip()
        if data:
            print('  ' * (self.depth+1) + data)

with open(sys.argv[1], 'r') as f:
    parser = MyHTMLParser()
    parser.feed(f.read())
