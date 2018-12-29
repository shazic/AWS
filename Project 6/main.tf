#####################################################################################################
### root/main.tf
#####################################################################################################

provider "aws" {
  region = "${var.region}"
}

module "network" {
  source = "./networking"
  cidr_block = "${var.vpc_cidr_block}"
  no_of_azs = "${var.no_of_azs}"
  public_subnet_cidr_blocks = "${var.public_subnet_cidr_blocks}"
  private_subnet_cidr_blocks = "${var.private_subnet_cidr_blocks}"
  db_subnet_cidr_blocks = "${var.db_subnet_cidr_blocks}"
  allowed_ips = "${var.allowed_ips}"
}
