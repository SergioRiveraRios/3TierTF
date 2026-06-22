output "vpc-id" {
    value = aws_vpc.testvpc.id
    description = "ID of the main vpc"
}

output "aws-dbsubnet-groupAZ1" {
    value = values(aws_subnet.subnets_az1)[1].id
    description = "db subnet for the db subnet group"
}

output "aws-dbsubnet-groupAZ2" {
    value = values(aws_subnet.subnets_az2)[1].id
    description = "db subnet for the db subnet group"
}

output "aws-appsubnet-groupAZ2" {
    value = values(aws_subnet.subnets_az2)[0].id
    description = "app subnet for the app subnet group"
}

output "aws-websubnet-group" {
   value = values(aws_subnet.subnets_az2)[2].id
    description = "app subnet for the app subnet group"
}