FROM n8nio/n8n:latest

# Installeer bash en wget voor het import script
USER root
RUN apk add --no-cache bash wget

# Kopieer import script
COPY import-workflows.sh /import-workflows.sh

# Maak executable in Linux (gebeurt in container, niet op Windows)
RUN chmod +x /import-workflows.sh

# Terug naar node user
USER node

# Gebruik bash expliciet om het script uit te voeren
ENTRYPOINT ["/bin/bash", "/import-workflows.sh"]