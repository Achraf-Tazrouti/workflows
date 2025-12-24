#!/bin/sh

echo "Importing workflows..."

n8n import:workflow --input=/workflows --separate --force

echo "Done."
