variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "ami_id" {
  description = "Ubuntu LTS AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "EC2 security group ID"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}