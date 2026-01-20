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

if [ -z "$ENV" ]; then
  echo "❌ ENV not provided. Expected: dev/test/demo/prod"
  exit 1
fi

echo "🚀 Deploying Branch Environment: $ENV"

export IMAGE_TAG="${ENV}-latest"

echo "📌 Using IMAGE_TAG=$IMAGE_TAG"
echo "📌 Pulling latest images..."
docker compose pull

echo "📌 Starting containers..."
docker compose up -d







