#####################################################################################################
### root/variables.tf
#####################################################################################################

variable "region" {
    description = "Region where the resources would be deployed (us-east-1, us-east-2, ap-south-1, etc.)"
    default = "us-east-1"
}

variable "vpc_cidr_block" {
    description = "CIDR block for the main VPC"
    default = "10.100.0.0/16"
}

variable "public_subnet_cidr_blocks" {
    description = "CIDR blocks for each Public subnet to be created. A public subnet for each AZ is recommended with minimum 2. "
    default = ["10.100.99.0/24", "10.100.199.0/24"]
}

variable "private_subnet_cidr_blocks" {
    description = "CIDR blocks for each Private subnet to be created. A subnet for each AZ is recommended with minimum 2. "
    default = ["10.100.59.0/24", "10.100.159.0/24"]
}

variable "db_subnet_cidr_blocks" {
    description = "CIDR blocks for each DB subnet to be created. A subnet for each AZ is recommended with minimum 2. "
    default = ["10.100.79.0/24", "10.100.179.0/24"]
}

variable "no_of_azs" {
    description = "Number of AZs to launch instances in. Make sure that the region supports these many AZs."
    default = 2
}

variable "allowed_ips" {
    description = "IPs allowed to access the bastion host"
    type = "list"
}

variable "db_port" {
    description = "Port on which the database is listening"
}