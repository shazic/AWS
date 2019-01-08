#####################################################################################################
### storage/variables.tf
### defines the variables for the storage layer
#####################################################################################################

variable "region" {
  description = "Region where the resources would be deployed (us-east-1, us-east-2, ap-south-1, etc.)"
}

variable "project_name" {
  description = "Project name"
}

variable "multi_az" {
  description = "Should the database be deployed in multi AZ (true/false)"
}

variable "db_storage_in_gb" {
  description = "Storage to be allocated to the db instance (in GB)"
}

variable "db_storage_type" {
  description = "Storage type for Database (io1, gp2, standard)"
}

variable "db_instance_identifier" {
  description = "The name of the RDS instance"
}

variable "db_engine" {
  description = "Database Engine (aurora, aurora-mysql, aurora-postgresql, mariadb, mysql, oracle-ee, oracle-se2, oracle-se1, oracle-se, postgres, sqlserver-ee, sqlserver-se, sqlserver-ex, sqlserver-web)"
}

variable "db_engine_version" {
  description = "Database Engine version"
}

variable "db_server_instance_class" {
  description = "Size of the application server"
}

variable "db_subnet_group_name" {
  description = "Subnet group name for the DB"
}

variable "db_security_group_ids" {
  description = "Security group ids for the application server"
  type        = "list"
}

variable "db_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi"
  default     = "Mon:00:00-Mon:03:00"
}

variable "db_name" {
  description = "Name of the database"
}

variable "db_username" {
  description = "Username for the database"
}

variable "db_password" {
  description = "Password for the user of the database"
}

variable "db_port" {
  description = "DB port number"
}

variable "db_parameter_group_name" {
  description = "Parameter Group Name"
}

variable "db_option_group_name" {
  description = "Option Group Name"
}

variable "backup_retention_period" {
  description = "Retention period for the backups in days (0-35)"
  default     = 0
}

variable "db_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created"
  default     = "02:00-05:30"
}

variable "db_allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed (true/false)"
  default     = false
}

variable "db_allow_minor_version_upgrade" {
  description = "Indicates that minor version upgrades are allowed (true/false) "
  default     = false
}

variable "s3_bucket_name" {
  description = "Bucket name for the object store"
}
