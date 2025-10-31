variable "aws_region" {
  description = "AWS region to create resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
  default     = "terraform-webapp"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for resources"
  type        = string
  default     = "a"
}

variable "key_pair_name" {
  description = "Name of the SSH key pair file (without .pub extension)"
  type        = string
  default     = "terraform-key"
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "Type of EBS volume"
  type        = string
  default     = "gp2"
}