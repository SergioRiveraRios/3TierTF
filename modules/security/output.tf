output "aws-db-securitygroup" {
  value = aws_security_group.aws-db-tier.id
  description = "security group for db"
}

output "aws-app-securitygroup-app" {
  value = aws_security_group.aws-apptier-sg.id
  description = "security group for app"
}

output "aws-web-securitygroup-app" {
  value = aws_security_group.aws-webtier-sg.id
  description = "security group for app"
}