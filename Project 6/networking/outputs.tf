#####################################################################################################
### networking/outputs.tf
### outputs from the network layer
#####################################################################################################

##############################
# VPC
##############################
output "vpc_arn" {
  value = "${aws_vpc.this.arn}"
}
output "vpc_id" {
  value = "${aws_vpc.this.id}"
}
output "vpc_cidr_block" {
  value = "${aws_vpc.this.cidr_block}"
}
output "vpc_instance_tenancy" {
  value = "${aws_vpc.this.instance_tenancy}"
}
output "vpc_dns_support" {
  value = "${aws_vpc.this.enable_dns_support}"
}
output "vpc_dns_hostnames" {
  value = "${aws_vpc.this.enable_dns_hostnames}"
}
output "vpc_main_route_table_id" {
  value = "${aws_vpc.this.main_route_table_id}"
}
output "vpc_default_network_acl_id" {
  value = "${aws_vpc.this.default_network_acl_id}"
}
output "vpc_default_security_group_id" {
  value = "${aws_vpc.this.default_security_group_id}"
}
output "vpc_default_route_table_id" {
  value = "${aws_vpc.this.default_route_table_id}"
}
output "vpc_owner_id" {
  value = "${aws_vpc.this.owner_id}"
}

###############
# IGW
###############
output "internet_gateway_id" {
  value = "${aws_internet_gateway.this.id}"
}

##############################
# Public Subnets
##############################
output "public_subnet_ids" {
  value = "${aws_subnet.public.*.id}"
}
output "public_subnet_cidr_blocks" {
  value = "${aws_subnet.public.*.cidr_block}"
}

##############################
# Private Subnets
##############################
output "private_subnet_ids" {
  value = "${aws_subnet.private.*.id}"
}
output "private_subnet_cidr_blocks" {
  value = "${aws_subnet.private.*.cidr_block}"
}

##############################
# DB Subnets and Subnet Group
##############################
output "db_private_subnet_ids" {
  value = "${aws_subnet.db_private.*.id}"
}
output "db_private_subnet_cidr_blocks" {
  value = "${aws_subnet.db_private.*.cidr_block}"
}
output "db_subnet_group_id" {
  value = "${aws_db_subnet_group.default.id}"
}

####################
# Public Route Table
####################
output "vpc_public_route_table_id" {
  value = "${aws_route_table.public.id}"
}

######################
# Private Route Table
######################
output "vpc_private_route_table_id" {
  value = "${aws_default_route_table.private.id}"
}

######################
# Security Groups
######################
output "bastion_host_security_group_id" {
    value = "${aws_security_group.bastion_host.id}"
}
output "open_internet_security_group_id" {
    value = "${aws_security_group.open_internet.id}"
}
output "app_server_security_group_id" {
    value = "${aws_security_group.application_server.id}"
}
output "db_security_group_id" {
    value = "${aws_security_group.db.id}"
}
