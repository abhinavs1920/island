from http.server import BaseHTTPRequestHandler, HTTPServer
import json

class LogHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        
        try:
            data = json.loads(post_data.decode('utf-8'))
            print(f"[{data.get('timestamp')}] {data.get('level')}: {data.get('message')}", flush=True)
            if data.get('error'):
                print(f"ERROR DETAILS: {data.get('error')}", flush=True)
            if data.get('stackTrace'):
                print(f"STACK TRACE:\n{data.get('stackTrace')}", flush=True)
        except:
            print("Received invalid JSON payload:", post_data.decode('utf-8'), flush=True)
            
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"OK")

    def log_message(self, format, *args):
        pass # Suppress standard HTTP logs

if __name__ == '__main__':
    server = HTTPServer(('0.0.0.0', 9999), LogHandler)
    print("Log server listening on port 9999...", flush=True)
    server.serve_forever()
