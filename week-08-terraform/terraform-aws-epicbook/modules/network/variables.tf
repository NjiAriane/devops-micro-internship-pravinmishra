variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_db_subnet_a_cidr" {
  description = "CIDR block for private database subnet A"
  type        = string
}

variable "private_db_subnet_b_cidr" {
  description = "CIDR block for private database subnet B"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability Zone for the public subnet"
  type        = string
}

variable "private_db_subnet_a_az" {
  description = "Availability Zone for private database subnet A"
  type        = string
}

variable "private_db_subnet_b_az" {
  description = "Availability Zone for private database subnet B"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR allowed to SSH to the EC2 instance"
  type        = string
}
