#####################################################################################################
### root/main.tf
#####################################################################################################

provider "aws" {
  region = "${var.region}"
}

module "network" {
  source = "./networking"
  project_name = "${var.project_name}"
  cidr_block = "${var.vpc_cidr_block}"
  no_of_azs = "${var.no_of_azs}"
  public_subnet_cidr_blocks = "${var.public_subnet_cidr_blocks}"
  private_subnet_cidr_blocks = "${var.private_subnet_cidr_blocks}"
  db_subnet_cidr_blocks = "${var.db_subnet_cidr_blocks}"
  allowed_ips = "${var.allowed_ips}"
  db_port = "${var.db_port}"
}

module "compute" {
  source = "./compute"
  project_name = "${var.project_name}"
  region = "${var.region}"
  no_of_azs = "${var.no_of_azs}"
  bastion_host_ami_ids = "${var.bastion_host_ami_ids}"
  bastion_host_instance_type = "${var.bastion_host_instance_type}"
  public_subnet_ids = "${module.network.public_subnet_ids}"
  bastion_host_security_group_id = "${module.network.bastion_host_security_group_id}"
}
