# #!/bin/bash
# set -e

# cd /home/ec2-user/deployment

# git pull origin main
# #vyk
# docker compose down
# docker compose pull
# docker compose up -d --force-recreate

# #!/bin/bash
# set -e

# cd /home/ec2-user/deployment

# if [ -z "$ENV" ]; then
#   echo "❌ ENV not provided. Expected: dev/test/demo/prod"
#   exit 1
# fi

# ENV_NAME="$ENV"
# echo "🚀 Deploying Branch Environment: $ENV_NAME"

# export ENV="$ENV_NAME"

# echo "📌 Pulling latest images..."
# docker compose pull

# echo "♻️ Restarting services..."
# docker compose up -d --force-recreate --remove-orphans

# echo "🧹 Cleaning old images..."
# docker image prune -f

# echo "✅ Deployment completed for $ENV_NAME"



#!/bin/bash
set -e

echo "BRANCH=$BRANCH"
echo "ENV=$ENV"

# ----------------------------
# PORTS PER BRANCH
# ----------------------------
if [ "$BRANCH" = "demo" ]; then
  FRONTEND_PORT=8081
  BACKEND_PORT=9081
elif [ "$BRANCH" = "dev" ]; then
  FRONTEND_PORT=8082
  BACKEND_PORT=9082
elif [ "$BRANCH" = "test" ]; then
  FRONTEND_PORT=8083
  BACKEND_PORT=9083
elif [ "$BRANCH" = "prod" ]; then
  FRONTEND_PORT=8084
  BACKEND_PORT=9084
else
  FRONTEND_PORT=8090
  BACKEND_PORT=9090
fi

echo "Frontend will run on PORT=$FRONTEND_PORT"
echo "Backend will run on PORT=$BACKEND_PORT"

# ----------------------------
# BACKEND DEPLOY
# ----------------------------
echo "✅ Deploying Backend..."
docker pull arunkumar885825/backend:${BRANCH}-latest

docker rm -f backend_${BRANCH} || true

docker run -d \
  --name backend_${BRANCH} \
  -p ${BACKEND_PORT}:8080 \
  arunkumar885825/backend:${BRANCH}-latest

# ----------------------------
# FRONTEND DEPLOY
# ----------------------------
echo "✅ Deploying Frontend..."
docker pull arunkumar885825/frontend:${BRANCH}-latest

docker rm -f frontend_${BRANCH} || true

docker run -d \
  --name frontend_${BRANCH} \
  -p ${FRONTEND_PORT}:80 \
  arunkumar885825/frontend:${BRANCH}-latest

echo "✅ Running containers:"
docker ps | egrep "frontend_${BRANCH}|backend_${BRANCH}"
