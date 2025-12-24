#!/bin/bash
set -e

# Start N8N
n8n &
N8N_PID=$!

# Wait for ready
for i in {1..30}; do
    wget --spider -q http://localhost:5678/healthz 2>/dev/null && break
    sleep 2
done

# Import workflows
for workflow in /workflows/*.json; do
    [ -f "$workflow" ] && n8n import:workflow --input="$workflow" 2>&1 | grep -v "Error" || true
done

wait $N8N_PID