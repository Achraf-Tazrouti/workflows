#!/bin/bash
set -e
echo "== Importeren van workflows =="
n8n import:workflow --input=/workflows/achraf_email_generator_chatbot.json || true
n8n import:workflow --input=/workflows/Achraf_template_checker_chat.json || true
n8n import:workflow --input=/workflows/chatbot_SenChraf.json || true
echo "== Importeren klaar =="
