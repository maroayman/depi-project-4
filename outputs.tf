output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.web.public_ip
}

output "website_url" {
  description = "URL of the web server"
  value       = "http://${aws_eip.web.public_ip}"
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh -i ${var.key_pair_name} ec2-user@${aws_eip.web.public_ip}"
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}