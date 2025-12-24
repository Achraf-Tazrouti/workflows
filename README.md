# N8N Workflows - ${CUSTOMER_ID}

N8N instance met geautomatiseerde workflow import.

## 🚀 Quick Start

```powershell
# 1. Kopieer .env.template naar .env en vul in
copy .env.template .env
notepad .env

# 2. Start
docker-compose up -d

# 3. Open N8N
# http://localhost:5678
```

## 📦 Workflows

- **Email Generator** - Genereert zakelijke emails
- **Template Checker** - Controleert email templates  
- **Invoice Chatbot** - Factuur analyse chatbot

## 🔧 Commands

```powershell
# Start
docker-compose up -d

# Stop
docker-compose down

# Logs bekijken
docker-compose logs -f

# Workflows updaten
# 1. Wijzig JSON files in /workflows
# 2. Rebuild: docker-compose up -d --build

# Fresh start
docker-compose down -v
docker-compose up -d --build
```

## 📝 Workflow toevoegen

1. Exporteer uit N8N UI (Download als JSON)
2. Plaats in `/workflows` folder
3. Rebuild: `docker-compose up -d --build`

## 🔐 Environment Variables

Zie `.env.template` voor alle opties.

Minimaal vereist:
- `CUSTOMER_ID` - Klant identificatie
- `MCP_BASE_URL` - API endpoint
- `API_KEY` - API authenticatie