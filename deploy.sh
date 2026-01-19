# #!/bin/bash
# set -e

# cd /home/ec2-user/deployment

# git pull origin main
# #vyk
# docker compose down
# docker compose pull
# docker compose up -d --force-recreate

#!/bin/bash
set -e

ENV_NAME="${1:-dev}"   # default dev

echo "✅ Starting deployment for environment: $ENV_NAME"
echo "📁 Current directory: $(pwd)"

# Compose file naming strategy:
# docker-compose.dev.yml / docker-compose.test.yml / docker-compose.demo.yml / docker-compose.prod.yml
COMPOSE_FILE="docker-compose.${ENV_NAME}.yml"

if [ ! -f "$COMPOSE_FILE" ]; then
  echo "❌ Compose file not found: $COMPOSE_FILE"
  echo "📌 Available files:"
  ls -la
  exit 1
fi

echo "🐳 Using compose file: $COMPOSE_FILE"

echo "📥 Pulling latest images..."
docker compose -f "$COMPOSE_FILE" pull

echo "🚀 Recreating containers..."
docker compose -f "$COMPOSE_FILE" up -d --force-recreate --remove-orphans

echo "✅ Deployment completed for: $ENV_NAME"
docker compose -f "$COMPOSE_FILE" ps


