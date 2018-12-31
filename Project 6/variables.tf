#####################################################################################################
### root/variables.tf
#####################################################################################################

variable "region" {
    description = "Region where the resources would be deployed (us-east-1, us-east-2, ap-south-1, etc.)"
    default = "us-east-1"
}

variable "project_name" {
    default = "HA-FT-App"
}

variable "no_of_azs" {
    description = "Number of AZs to launch instances in. Make sure that the region supports these many AZs."
    default = 2
}

#############################
# Network Variables
#############################

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

variable "allowed_ips" {
    description = "IPs allowed to access the bastion host"
    type = "list"
}

variable "db_port" {
    description = "Port on which the database is listening"
}

#############################
# Compute Variables
#############################

variable "no_of_bastion_hosts" {
    description = "How many bastion hosts are required?"
    default = "2"
}

variable "bastion_host_ami_ids" {
    description = "AMI Id of the bastion host"
    type = "map"

    default {
        "us-east-1"     = "ami-0080e4c5bc078760e"   // N Virginia
        "us-east-2"     = "ami-0cd3dfa4e37921605"   // Ohio
        "us-west-1"     = "ami-0ec6517f6edbf8044"   // N California
        "us-west-2"     = "ami-01e24be29428c15b2"   // Oregon
        "ap-south-1"    = "ami-0ad42f4f66f6c1cc9"   // Mumbai
        "ap-northeast-2"= "ami-00dc207f8ba6dc919"   // Seoul
        "ap-southeast-1"= "ami-05b3bcf7f311194b3"   // Singapore
        "ap-southeast-2"= "ami-02fd0b06f06d93dfc"   // Sydney
        "ap-northeast-1"= "ami-00a5245b4816c38e6"   // Tokyo
        "ca-central-1"  = "ami-07423fb63ea0a0930"   // Canada
        "eu-central-1"  = "ami-0cfbf4f6db41068ac"   // Frankfurt
        "eu-west-1"     = "ami-08935252a36e25f85"   // Ireland
        "eu-west-2"     = "ami-01419b804382064e4"   // London
        "eu-west-3"     = "ami-0dd7e7ed60da8fb83"   // Paris
        "eu-north-1"    = "ami-86fe70f8"            // Stockholm
        "sa-east-1"     = "ami-05145e0b28ad8e0b2"   // Sao Paulo
    }
}

variable "bastion_host_instance_type" {
    description = "Size of the bastion host"
    default = "t2.micro"
}

variable "application_ami_ids" {
    description = "AMI Id of the application"
    type = "map"

    default {
        "us-east-1"     = "ami-0080e4c5bc078760e"   // N Virginia
        "us-east-2"     = "ami-0cd3dfa4e37921605"   // Ohio
        "us-west-1"     = "ami-0ec6517f6edbf8044"   // N California
        "us-west-2"     = "ami-01e24be29428c15b2"   // Oregon
        "ap-south-1"    = "ami-0ad42f4f66f6c1cc9"   // Mumbai
        "ap-northeast-2"= "ami-00dc207f8ba6dc919"   // Seoul
        "ap-southeast-1"= "ami-05b3bcf7f311194b3"   // Singapore
        "ap-southeast-2"= "ami-02fd0b06f06d93dfc"   // Sydney
        "ap-northeast-1"= "ami-00a5245b4816c38e6"   // Tokyo
        "ca-central-1"  = "ami-07423fb63ea0a0930"   // Canada
        "eu-central-1"  = "ami-0cfbf4f6db41068ac"   // Frankfurt
        "eu-west-1"     = "ami-08935252a36e25f85"   // Ireland
        "eu-west-2"     = "ami-01419b804382064e4"   // London
        "eu-west-3"     = "ami-0dd7e7ed60da8fb83"   // Paris
        "eu-north-1"    = "ami-86fe70f8"            // Stockholm
        "sa-east-1"     = "ami-05145e0b28ad8e0b2"   // Sao Paulo
    }
}

variable "application_server_instance_type" {
    description = "Size of the application server"
    default = "t2.micro"
}

variable "application_instance_profile" {
    description = "IAM instance profile for the application instances"
    default = "default"
}
