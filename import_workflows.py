#!/usr/bin/env python3
"""
N8N Workflow Importer - imports workflows via REST API
"""
import os
import json
import time
import requests
import sys
from pathlib import Path

N8N_URL = os.getenv('N8N_URL', 'http://localhost:5678')
WORKFLOWS_DIR = '/workflows'
MAX_RETRIES = 60
RETRY_DELAY = 1

def wait_for_n8n():
    """Wait for N8N API to be ready"""
    print("[IMPORT] Waiting for N8N API to be ready...")
    for attempt in range(MAX_RETRIES):
        try:
            response = requests.get(f'{N8N_URL}/api/v1/health', timeout=2)
            if response.status_code == 200:
                print(f"[IMPORT] ✅ N8N API is ready (attempt {attempt + 1})")
                return True
        except requests.exceptions.RequestException:
            pass
        time.sleep(RETRY_DELAY)
    
    print(f"[IMPORT] ⚠️  N8N API did not respond after {MAX_RETRIES} seconds")
    return False

def get_user_id():
    """Get the first user ID from N8N"""
    try:
        response = requests.get(f'{N8N_URL}/api/v1/users', timeout=5)
        if response.status_code == 200:
            data = response.json()
            if isinstance(data, dict) and 'data' in data and len(data['data']) > 0:
                user_id = data['data'][0].get('id')
                print(f"[IMPORT] Found user ID: {user_id}")
                return user_id
    except Exception as e:
        print(f"[IMPORT] ⚠️  Could not get user ID: {e}")
    return None

def import_workflow_via_api(workflow_file, user_id):
    """Import workflow via REST API"""
    try:
        with open(workflow_file, 'r') as f:
            workflow_data = json.load(f)
        
        filename = os.path.basename(workflow_file)
        print(f"[IMPORT] Importing {filename}...")
        
        # Prepare import data
        import_data = {
            'data': [workflow_data]
        }
        
        # Add user ID if available
        if user_id:
            import_data['userId'] = user_id
        
        # Call N8N import API
        response = requests.post(
            f'{N8N_URL}/api/v1/workflows/import',
            json=import_data,
            timeout=10
        )
        
        if response.status_code in [200, 201]:
            print(f"[IMPORT] ✅ Successfully imported {filename}")
            return True
        else:
            print(f"[IMPORT] ⚠️  Import failed for {filename}: HTTP {response.status_code}")
            print(f"         Response: {response.text[:200]}")
            return False
    except Exception as e:
        print(f"[IMPORT] ❌ Error importing {filename}: {e}")
        return False

def main():
    print("[IMPORT] Starting N8N Workflow Importer")
    
    # Wait for N8N
    if not wait_for_n8n():
        print("[IMPORT] ❌ Could not connect to N8N, exiting")
        sys.exit(1)
    
    # Get user ID
    user_id = get_user_id()
    
    # Find and import workflows
    if not os.path.isdir(WORKFLOWS_DIR):
        print(f"[IMPORT] ⚠️  Workflows directory not found: {WORKFLOWS_DIR}")
        return
    
    workflow_files = list(Path(WORKFLOWS_DIR).glob('*.json'))
    
    if not workflow_files:
        print("[IMPORT] ⚠️  No .json workflow files found")
        return
    
    print(f"[IMPORT] Found {len(workflow_files)} workflow files")
    
    imported = 0
    for workflow_file in workflow_files:
        if import_workflow_via_api(str(workflow_file), user_id):
            imported += 1
    
    print(f"[IMPORT] ✅ Import complete: {imported}/{len(workflow_files)} workflows imported")

if __name__ == '__main__':
    main()
