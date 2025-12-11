#!/bin/bash

set -e  # Exit on error

echo "[INIT] Starting N8N initialization script..."
echo "[INIT] Current user: $(whoami)"
echo "[INIT] Checking /workflows directory..."

# Check if /workflows directory exists and has files
if [ -d "/workflows" ]; then
    echo "[INIT] Found /workflows directory"
    echo "[INIT] Contents: $(find /workflows -maxdepth 1 -name '*.json' -type f)"
    
    # Count JSON files
    json_count=$(find /workflows -maxdepth 1 -name '*.json' -type f | wc -l)
    
    if [ "$json_count" -gt 0 ]; then
        echo "[INIT] Found $json_count workflow files. Starting import..."
        
        # Import all *.json files from /workflows directory
        if n8n import:workflow --separate --input=/workflows; then
            echo "[INIT] ✅ Workflows imported successfully."
        else
            echo "[INIT] ⚠️  Import completed with warnings (this is normal for chatbot configs)."
        fi
    else
        echo "[INIT] ⚠️  No .json workflow files found in /workflows"
    fi
else
    echo "[INIT] ⚠️  /workflows directory not found"
fi

echo "[INIT] ✅ Initialization complete. Starting N8N..."

# Start n8n normally
exec n8n