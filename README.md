# Dockerized Web Platform on AWS (DevOps Project)

## Overview

This project demonstrates a production-style DevOps setup for deploying a containerized multi-service web application on AWS using Infrastructure as Code, configuration management, and CI/CD pipelines.

The platform includes:

- AWS EC2 infrastructure provisioned with Terraform
- Custom VPC with public subnet and internet gateway
- Host configuration using Ansible
- Multi-container application using Docker Compose
- Nginx reverse proxy for traffic routing
- PostgreSQL database with persistent storage
- CI/CD pipelines using GitHub Actions and GitLab CI
- Automated deployment via SSH

---

## Architecture

### Layers

- **Infrastructure Layer**
  - AWS EC2
  - Custom VPC, Subnet, Internet Gateway
  - Security Groups

- **Configuration Layer**
  - Ansible installs Docker and prepares host

- **Runtime Layer**
  - Docker Compose orchestrates services
  - Nginx handles incoming requests
  - Flask app serves API
  - PostgreSQL stores data

- **CI/CD Layer**
  - GitHub Actions: CI + manual CD
  - GitLab CI: validation + deployment

---

## Tech Stack

- AWS EC2
- Terraform
- Ansible
- Docker & Docker Compose
- Nginx
- PostgreSQL
- Python (Flask)
- GitHub Actions
- GitLab CI

---

## Features

- Containerized multi-service architecture
- Reverse proxy using Nginx
- Persistent database storage using Docker volumes
- Health check endpoint (`/health`)
- Automated deployment via CI/CD
- Manual deployment script for controlled releases
- Logging and operational scripts

---

## Deployment Flow

1. Terraform provisions infrastructure
2. Ansible configures the EC2 host
3. Application is containerized using Docker
4. Docker Compose runs services
5. CI validates code (Terraform, Ansible, Docker)
6. CD deploys application via SSH

---

## How to Deploy

### Manual Deployment

```bash
cd scripts
./deploy.sh <EC2_PUBLIC_IP>

curl http://<EC2_PUBLIC_IP>/health

./scripts/logs.sh <EC2_IP>

./scripts/restart_stack.sh <EC2_IP>

Key DevOps Concepts Demonstrated

Infrastructure as Code (Terraform)

Configuration Management (Ansible)

Containerization (Docker)

Service Orchestration (Docker Compose)

Reverse Proxy Architecture (Nginx)

CI/CD Pipelines

Stateless vs Stateful services

Health checks and observability basics

Improvements / Future Work

HTTPS with Let's Encrypt (requires domain)

Use Docker image registry (ECR/Docker Hub)

Immutable image deployment (tag-based)

Blue/Green deployment strategy

Move to Kubernetes for orchestration
