#!/bin/bash
set -euo pipefail

EC2_IP="${1:-}"
SSH_KEY="${HOME}/.ssh/devops-terraform-key"
REMOTE_USER="ubuntu"
REMOTE_BASE_DIR="/opt/devops-docker-platform"

if [ -z "$EC2_IP" ]; then
  echo "Usage: ./deploy.sh <EC2_PUBLIC_IP>"
  exit 1
fi

echo "Starting deployment to ${EC2_IP}..."

echo "Copying app files..."
scp -i "${SSH_KEY}" -r "${HOME}/projects/devops-project-4-docker-platform/app" "${REMOTE_USER}@${EC2_IP}:${REMOTE_BASE_DIR}/"

echo "Copying nginx files..."
scp -i "${SSH_KEY}" -r "${HOME}/projects/devops-project-4-docker-platform/nginx" "${REMOTE_USER}@${EC2_IP}:${REMOTE_BASE_DIR}/"

echo "Copying compose files..."
scp -i "${SSH_KEY}" -r "${HOME}/projects/devops-project-4-docker-platform/compose" "${REMOTE_USER}@${EC2_IP}:${REMOTE_BASE_DIR}/"

echo "Deploying containers..."
ssh -i "${SSH_KEY}" "${REMOTE_USER}@${EC2_IP}" <<EOF
  set -e
  cd ${REMOTE_BASE_DIR}/compose
  docker compose up -d --build
  docker compose ps
EOF

echo "Running health check..."
curl --fail --silent "http://${EC2_IP}/health" && echo
echo "Deployment completed successfully."
