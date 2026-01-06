#!/bin/bash
set -e

echo "📥 Pull latest deployment repo changes"
git pull origin main

echo "📦 Pull latest images from Docker Hub"
docker compose pull

echo "♻️ Recreate containers"
docker compose up -d --force-recreate --remove-orphans

~
~
