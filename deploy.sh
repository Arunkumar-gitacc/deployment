#!/bin/bash
set -e

cd /home/ec2-user/deployment

git pull origin main

docker compose down
docker compose pull
docker compose up -d --force-recreate
