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
  application_server_key_name = "${var.application_server_key_name}"

  max_application_cluster_size = "${var.max_application_cluster_size}"
  min_application_cluster_size = "${var.min_application_cluster_size}"
  desired_capacity = "${var.desired_capacity}"
  application_security_group_ids = "${module.network.app_server_security_group_id}"

  load_balancer_security_group_id = "${module.network.open_internet_security_group_id}"

}

module "storage" {
  source = "./storage"
  project_name = "${var.project_name}"
  region = "${var.region}"
  
  multi_az = "${var.multi_az}"

  db_instance_identifier = "${var.db_name}-${var.db_engine}-database"
  db_storage_in_gb = "${var.db_storage_in_gb}"
  db_storage_type = "${var.db_storage_type}"
  db_engine = "${var.db_engine}"
  db_engine_version = "${var.db_engine_version}"
  db_server_instance_class = "${var.db_server_instance_class}"
  db_security_group_ids = ["${module.network.db_security_group_id}"]
  db_subnet_group_name = "${module.network.db_subnet_group_name}"

  db_parameter_group_name = "${var.db_parameter_group_name}"
  db_option_group_name = "${var.db_option_group_name}"
  
  db_name = "${var.db_name}"
  db_username = "${var.db_username}"
  db_password = "${var.db_password}"
  db_port  = "${var.db_port}"

  backup_retention_period = "${var.backup_retention_period}"
  db_backup_window = "${var.db_backup_window}"
  db_maintenance_window = "${var.db_maintenance_window}"
  db_allow_major_version_upgrade = "${var.db_allow_major_version_upgrade}"
  db_allow_minor_version_upgrade  = "${var.db_allow_minor_version_upgrade}"

  db_parameter_group_name = "${var.db_parameter_group_name}"
  db_option_group_name = "${var.db_option_group_name}"
}
