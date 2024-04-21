output "rds_instance_arn" {
  value       = aws_db_instance.this.arn
  description = "The ARN of the created RDS instance."
}

output "rds_instance_id" {
  value       = aws_db_instance.this.id
  description = "The ID of the created RDS instance."
}

output "rds_instance_address" {
  value       = aws_db_instance.this.address
  description = "The hostname of the created RDS instance."
}

output "rds_instance_port" {
  value       = aws_db_instance.this.port
  description = "The port of the created RDS instance."
}

output "rds_instance_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "The endpoint of the created RDS instance in address:port format."
}