output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_db_subnet_a_id" {
  description = "ID of private database subnet A"
  value       = aws_subnet.private_db_a.id
}

output "private_db_subnet_b_id" {
  description = "ID of private database subnet B"
  value       = aws_subnet.private_db_b.id
}

output "ec2_security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ec2.id
}

output "rds_security_group_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds.id
}
