# -------------------------------
# Output EC2 Public IP
# -------------------------------

# This prints the public IP of the EC2 instance
# after Terraform apply completes

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}
# -------------------------------
# Output EC2 Public DNS
# -------------------------------

# This prints the public DNS name of the EC2 instance

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web.public_dns
}