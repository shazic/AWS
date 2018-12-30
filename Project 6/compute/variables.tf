#####################################################################################################
### compute/variables.tf
### defines the variables for the compute layer
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

variable "bastion_host_ami_ids" {
    type = "map"
    description = "AMI Id of the bastion host"
}

variable "bastion_host_instance_type" {
    description = "Size of the bastion host"
}

variable "bastion_host_security_group_id" {
    description = "security group for the bastion host"
}

variable "public_subnet_ids" {
    type = "list"
}
