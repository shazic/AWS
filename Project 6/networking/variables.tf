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

variable "no_of_azs" {
  description = "Number of AZs to launch instances in"
}

variable "allowed_ips" {
  description = "IPs allowed to access the bastion host"
  type        = "list"
}

variable "db_port" {
  description = "Port on which the database is listening"
}
