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

variable "vpc_id" {
    description = "VPC id of an existing VPC where the application is to be depployed"
}

variable "no_of_bastion_hosts" {
    description = "How many bastion hosts are required?"
    default = 1
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

variable "bastion_host_key_name" {
    description = "A key pair for the bastion host to connect to."
}

variable "public_subnet_ids" {
    type = "list"
}

variable "private_subnet_ids" {
    type = "list"
}

variable "load_balancer_security_group_id" {
    description = "Security group for the load balancer accepting internet traffic"
}

variable "application_ami_ids" {
    description = "AMI Id of the application"
    type = "map"
}

variable "application_server_instance_type" {
    description = "Size of the application server"
}

variable "application_instance_profile" {
    description = "IAM instance profile for the application instances"
    default = ""
}

variable "application_server_key_name" {
    description = "A key pair name for the application server"
}

variable "max_application_cluster_size" {
    description = "Max limit of ec2 instances while scaling the application"
}

variable "min_application_cluster_size" {
    description = "Min limit of ec2 instances while scaling the application"
}

variable "desired_capacity" {
    description = "Desired size of the application cluster"
}

variable "application_security_group_ids" {
    description = "Security group ids for the application server"
}
