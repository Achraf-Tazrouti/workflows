#!/bin/bash

echo "[INIT] Starting N8N in background..."
n8n &
N8N_PID=$!

# Wacht tot de API klaar is
echo "[INIT] Waiting for N8N API..."
until curl -s http://localhost:5678/api/v1/health > /dev/null; do
	sleep 2
done

# Importeer alle workflows
if [ -d "/workflows" ]; then
	json_count=$(find /workflows -maxdepth 1 -name '*.json' -type f 2>/dev/null | wc -l)
	if [ "$json_count" -gt 0 ]; then
		echo "[INIT] Importing $json_count workflows..."
		n8n import:workflow --separate --input=/workflows || true
	fi
fi

# Breng N8N naar de voorgrond
wait $N8N_PID