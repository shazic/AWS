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
  
  vpc_id = "${module.network.vpc_id}"

  public_subnet_ids = "${module.network.public_subnet_ids}"
  private_subnet_ids = "${module.network.private_subnet_ids}"
  
  no_of_bastion_hosts = "${var.no_of_bastion_hosts}"              // Optional. Defaults to 1.
  bastion_host_ami_ids = "${var.bastion_host_ami_ids}"
  bastion_host_instance_type = "${var.bastion_host_instance_type}"
  bastion_host_security_group_id = "${module.network.bastion_host_security_group_id}"
  bastion_host_key_name = "${var.bastion_host_key_name}"
  
  application_ami_ids = "${var.application_ami_ids}"
  application_server_instance_type = "${var.application_server_instance_type}"
  application_instance_profile = "${var.application_instance_profile}"
  max_application_cluster_size = "${var.max_application_cluster_size}"
  min_application_cluster_size = "${var.min_application_cluster_size}"
  desired_capacity = "${var.desired_capacity}"
  application_security_group_ids = "${module.network.app_server_security_group_id}"

  load_balancer_security_group_id = "${module.network.open_internet_security_group_id}"

}
