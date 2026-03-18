#!/bin/bash
set -euo pipefail

EC2_IP="${1:-}"
SERVICE_NAME="${2:-}"
SSH_KEY="${HOME}/.ssh/devops-terraform-key"
REMOTE_USER="ubuntu"
REMOTE_COMPOSE_DIR="/opt/devops-docker-platform/compose"

if [ -z "$EC2_IP" ]; then
  echo "Usage: ./logs.sh <EC2_PUBLIC_IP> [service_name]"
  exit 1
fi

if [ -n "$SERVICE_NAME" ]; then
  ssh -i "${SSH_KEY}" "${REMOTE_USER}@${EC2_IP}" "cd ${REMOTE_COMPOSE_DIR} && docker compose logs --tail=100 ${SERVICE_NAME}"
else
  ssh -i "${SSH_KEY}" "${REMOTE_USER}@${EC2_IP}" "cd ${REMOTE_COMPOSE_DIR} && docker compose logs --tail=100"
fi
