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

cd /home/ec2-user/deployment

if [ -z "$ENV" ]; then
  echo "❌ ENV not provided. Expected: dev/test/demo/prod"
  exit 1
fi

ENV_NAME="$ENV"
echo "🚀 Deploying Branch Environment: $ENV_NAME"

export ENV="$ENV_NAME"

echo "📌 Pulling latest images..."
docker compose pull

echo "♻️ Restarting services...."
docker compose up -d --force-recreate --remove-orphans

echo "🧹 Cleaning old images..."
docker image prune -f

echo "✅ Deployment completed for $ENV_NAME"




