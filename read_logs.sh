#!/bin/bash
curl -s https://crudcrud.com/api/b6c4339a452344c29ff292aa7e96ecdc/logs | jq -r '.[] | "[\(.timestamp)] \(.level): \(.message)"'
