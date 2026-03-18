output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.docker_host.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.docker_host.public_dns
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "ssh_command" {
  description = "SSH command to connect to EC2"
  value       = "ssh -i ~/.ssh/devops-terraform-key ubuntu@${aws_instance.docker_host.public_ip}"
}
