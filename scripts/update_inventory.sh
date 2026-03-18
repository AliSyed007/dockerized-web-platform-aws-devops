#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./update_inventory.sh <EC2_PUBLIC_IP>"
  exit 1
fi

EC2_PUBLIC_IP="$1"
INVENTORY_FILE="$HOME/projects/devops-project-4-docker-platform/ansible/inventory.ini"

cat > "$INVENTORY_FILE" <<EOF
[docker_hosts]
$EC2_PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/devops-terraform-key
EOF

echo "Updated inventory file: $INVENTORY_FILE"
cat "$INVENTORY_FILE"
