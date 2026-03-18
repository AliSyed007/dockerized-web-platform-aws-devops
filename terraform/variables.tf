variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR format for SSH access"
  type        = string
}
