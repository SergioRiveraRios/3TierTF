variable "aws-loadbalancer-Internet" {
    type = string
    description = "Name for the load balancer facing internet"
    default = "InternetLB"
}
variable "aws-loadbalancer-Internal" {
    type = string
    description = "Name for the load balancer facing internal"
    default = "InternalLB"
}

variable "aws-vpc" {
    type = string
    description = "vpc id"
}

variable "aws-webtier-name" {
    type = string
    description = "Security group name for web"
    default = "aws-webtier"
}
variable "aws-apptier-name" {
    type = string
    description = "Security group name for app"
    default = "aws-apptier"
}
variable "aws-dbtier-name" {
    type = string
    description = "Security group name for db"
    default = "aws-dbtier"
}