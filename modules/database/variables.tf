
variable "aws-dbsubnetgroupAZ1" {
    type = string
    description = "subnets of the db subgroup"
}
variable "aws-dbsubnetgroupAZ2" {
    type = string
    description = "subnets of the db subgroup"
}
variable "aws-securitygroup" {
  type = string
  description = "security group for DB"
}