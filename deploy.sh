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

# Docker Hub username
DOCKER_USER="arunkumar885825"

# Get Git commit SHA (short)
IMAGE_TAG=$(git rev-parse --short HEAD)

echo "🔖 Image tag: $IMAGE_TAG"

echo "🔐 Logging into Docker Hub"
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USER" --password-stdin

# ---------------- FRONTEND ----------------
echo "📦 Building frontend image"
docker build -t $DOCKER_USER/frontend:$IMAGE_TAG ./frontend

echo "📤 Pushing frontend image"
docker push $DOCKER_USER/frontend:$IMAGE_TAG

# ---------------- BACKEND ----------------
echo "📦 Building backend image"
docker build -t $DOCKER_USER/backend:$IMAGE_TAG ./backend

echo "📤 Pushing backend image"
docker push $DOCKER_USER/backend:$IMAGE_TAG

echo "✅ Images built and pushed successfully"

