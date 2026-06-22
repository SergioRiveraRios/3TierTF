variable "cidr_block" {
    type = string
    description = "cidr block for the default VPC"
}

variable "vpcname" {
    type = string
    description = "default name for the vpc"
}

variable "subnetsAZ1" {
    type = map(string)
    description = "subnetlist for the AZ1"
    default = {
      "WebTierAZ1" = "10.0.10.0/24"
      "AppTierAZ1" = "10.0.11.0/24"
      "DBTierAZ1" = "10.0.12.0/24"
    }
} 

variable "subnetsAZ2" {
    type = map(string)
    description = "subnetlist for the AZ1"
    default = {
      "WebTierAZ2" = "10.0.20.0/24"
      "AppTierAZ2" = "10.0.21.0/24"
      "DBTierAZ2" = "10.0.22.0/24"
    }
}   