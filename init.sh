#!/bin/bash

echo "[INIT] Importing workflows from /workflows..."

# Import all workflows from the Git-bound directory
n8n import:workflow --input=/workflows

echo "[INIT] Workflows imported successfully."

# Start n8n normally
exec n8n
