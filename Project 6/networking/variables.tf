#####################################################################################################
### networking/variables.tf
### defines the variables for the network layer
#####################################################################################################

variable "project_name" {
    default = "HA-FT-App"
}

variable "cidr_block" {
    description = "CIDR block for the main VPC"
}

variable "public_subnet_cidr_blocks" { 
    description = "CIDR blocks for each Public subnet to be created. A public subnet for each AZ is recommended with minimum 2. "
    type = "list"
}

variable "private_subnet_cidr_blocks" { 
    description = "CIDR blocks for each Private subnet to be created. A subnet for each AZ is recommended with minimum 2. "
    type = "list"
}

variable "db_subnet_cidr_blocks" { 
    description = "CIDR blocks for each DB subnet to be created. A subnet for each AZ is recommended with minimum 2. "
    type = "list"
}

variable "no_of_azs" {
    description = "Number of AZs to launch instances in"
}

variable "allowed_ips" {
    description = "IPs allowed to access the bastion host"
    type = "list"
}

variable "db_port" {
    description = "Port on which the database is listening"
}

