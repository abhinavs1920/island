#!/bin/bash
python3 logger.py &
./cloudflared tunnel --url http://localhost:9999
