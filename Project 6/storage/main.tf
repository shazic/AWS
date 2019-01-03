#####################################################################################################
### storage/main.tf
### defines the storage/database layer
#####################################################################################################

# Get the avaialable AZs
data "aws_availability_zones" "available" {}

resource "aws_db_instance" "main" {
    multi_az                = "${var.multi_az}"

    allocated_storage       = "${var.db_storage_in_gb}"
    storage_type            = "${var.db_storage_type}"
    
    identifier              = "${var.db_instance_identifier}"
    
    engine                  = "${var.db_engine}"
    engine_version          = "${var.db_engine_version}"
    
    instance_class          = "${var.db_server_instance_class}"
    
    name                    = "${var.db_name}"
    username                = "${var.db_username}"
    password                = "${var.db_password}"
    port                    = "${var.db_port}"
    
    /*
     * Currently, HCL does not support conditionally omit a parameter (see https://github.com/hashicorp/terraform/issues/14037).
     * If you need to associate a parameter group or option group with the RDS instance, remove # from the below lines. 
     */
    # parameter_group_name    = "${var.db_parameter_group_name}"
    # option_group_name       = "${var.db_option_group_name}"
    
    db_subnet_group_name    = "${var.db_subnet_group_name}"
    vpc_security_group_ids  = ["${var.db_security_group_ids}"]

    maintenance_window      = "${var.db_maintenance_window}"

    backup_retention_period = "${var.backup_retention_period}"
    backup_window           = ""

    allow_major_version_upgrade = "${var.db_allow_major_version_upgrade}"
    auto_minor_version_upgrade  = "${var.db_allow_minor_version_upgrade}"

    tags {
        Name = "${var.project_name}-RDS"
         Project = "${var.project_name}"
    }
}
