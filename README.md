✨ n8n Workflows Repository

Dit is de centrale repository waar alle n8n-workflows worden opgeslagen.
Elke workflow wordt uit n8n geëxporteerd als een .json bestand.

📌 Doel van deze repository

📁 Workflows centraal bewaren in Git

🔄 Versiebeheer en geschiedenis bijhouden

🛡 Backups van alle flows

🐳 Workflows kunnen syncen naar Docker-omgevingen

♻️ Herbruikbare workflows voor andere projecten of klanten

📥 Workflow exporteren (n8n → JSON)

Open een workflow in n8n

Klik rechtsboven op ⋯ (drie puntjes)

Selecteer Download

n8n genereert een .json bestand

Plaats dit bestand in de map workflows/ van deze repository

📤 Workflow importeren (JSON → n8n)

Open n8n

Klik op New Workflow

Klik rechtsboven op ⋯

Selecteer Import from File

Kies het .json bestand

De workflow wordt automatisch geladen

🐳 Docker integratie (voor later)

In productie kunnen n8n-containers workflows automatisch inladen vanuit deze Git-repository.
Dit zorgt voor:

consistente deployments

centraal workflowbeheer

eenvoudige updates

veilige en gestructureerde workflow management

📂 Repository structuur
workflows/
   chatbot_SenChraf.json
   achraf_email_generator_chatbot.json
   Achraf_template_checker_chat.json

👤 Auteur

Achraf Tazrouti
n8n Workflow Developer
