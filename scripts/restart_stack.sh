#!/bin/bash
set -euo pipefail

EC2_IP="${1:-}"
SSH_KEY="${HOME}/.ssh/devops-terraform-key"
REMOTE_USER="ubuntu"
REMOTE_COMPOSE_DIR="/opt/devops-docker-platform/compose"

if [ -z "$EC2_IP" ]; then
  echo "Usage: ./restart_stack.sh <EC2_PUBLIC_IP>"
  exit 1
fi

ssh -i "${SSH_KEY}" "${REMOTE_USER}@${EC2_IP}" <<EOF
  set -e
  cd ${REMOTE_COMPOSE_DIR}
  docker compose down
  docker compose up -d --build
  docker compose ps
EOF
