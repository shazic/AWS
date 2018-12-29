#####################################################################################################
### root/outputs.tf
#####################################################################################################

##############################
# Networking Components
##############################

# VPC
output "vpc_arn" {
  value = "${module.network.vpc_arn}"
}
output "vpc_id" {
  value = "${module.network.vpc_id}"
}
output "vpc_cidr_block" {
  value = "${module.network.vpc_cidr_block}"
}

# IGW
output "internet_gateway_id" {
  value = "${module.network.internet_gateway_id}"
}

# Public Subnets
output "public_subnet_ids" {
  value = "${module.network.public_subnet_ids}"
}
output "public_subnet_cidr_blocks" {
  value = "${module.network.public_subnet_cidr_blocks}"
}

# Private Subnets
output "private_subnet_ids" {
  value = "${module.network.private_subnet_ids}"
}
output "private_subnet_cidr_blocks" {
  value = "${module.network.private_subnet_cidr_blocks}"
}

# DB Subnets and Subnet Group
output "db_private_subnet_ids" {
  value = "${module.network.db_private_subnet_ids}"
}
output "db_private_subnet_cidr_blocks" {
  value = "${module.network.db_private_subnet_cidr_blocks}"
}
output "db_subnet_group_id" {
  value = "${module.network.db_subnet_group_id}"
}

# Public Route Table
output "vpc_public_route_table_id" {
  value = "${module.network.vpc_public_route_table_id}"
}

# Private Route Table
output "vpc_private_route_table_id" {
  value = "${module.network.vpc_private_route_table_id}"
}

# Security Groups
output "bastion_host_security_group_id" {
    value = "${module.network.bastion_host_security_group_id}"
}
output "open_internet_security_group_id" {
    value = "${module.network.open_internet_security_group_id}"
}
output "app_server_security_group_id" {
    value = "${module.network.app_server_security_group_id}"
}
output "db_security_group_id" {
    value = "${module.network.db_security_group_id}"
}
