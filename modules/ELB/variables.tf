variable "aws-vpc" {
    type = string
    description = "vpc id"
}

variable "ALB_security_group" {
    type = string
    description = "vpc id"
}

variable "ALB_Subnet1" {
    type = string
    description = "vpc id"
}
variable "ALB_Subnet2" {
    type = string
    description = "vpc id"
}

variable "ami_webtier" {
    type = string
}

variable "web-tier-security-group" {
    type = string
}