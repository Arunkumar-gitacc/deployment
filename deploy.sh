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

ENVIRONMENT=$1
IMAGE_TAG=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$IMAGE_TAG" ]; then
  echo "❌ Usage: ./deploy.sh <dev|test|demo|prod> <image-tag>"
  exit 1
fi

echo "🚀 Deploying environment: $ENVIRONMENT"
echo "🔖 Image tag: $IMAGE_TAG"

cd /home/ec2-user/deployment/$ENVIRONMENT

export FRONTEND_IMAGE_TAG=$IMAGE_TAG
export BACKEND_IMAGE_TAG=$IMAGE_TAG

docker compose pull
docker compose up -d --force-recreate --remove-orphans

echo "✅ Deployment completed for $ENVIRONMENT"

