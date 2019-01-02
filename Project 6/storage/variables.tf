#####################################################################################################
### storage/variables.tf
### defines the variables for the storage layer
#####################################################################################################

variable "region" {
    description = "Region where the resources would be deployed (us-east-1, us-east-2, ap-south-1, etc.)"
}

variable "project_name" {
    description = "Project name"
}

variable "no_of_azs" {
    description = "Number of AZs to launch instances in. Make sure that the region supports these many AZs."
}

variable "vpc_id" {
    description = "VPC id of an existing VPC where the application is to be depployed"
}

variable "public_subnet_ids" {
    type = "list"
}

variable "private_subnet_ids" {
    type = "list"
}

variable "db_server_instance_type" {
    description = "Size of the application server"
}

variable "db_security_group_ids" {
    description = "Security group ids for the application server"
}
