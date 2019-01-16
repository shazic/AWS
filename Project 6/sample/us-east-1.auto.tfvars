region = "us-east-1"
project_name = "HA-FT-App"
no_of_azs = "4"

vpc_cidr_block = "10.2.0.0/16"
allowed_ips = ["0.0.0.0/0"]

no_of_bastion_hosts = "3"
bastion_host_instance_type = "t2.nano"
bastion_host_key_name = "us-east-1-key-pair"

application_server_instance_type = "t2.nano"
max_application_cluster_size = 5
min_application_cluster_size = 1
desired_capacity = 4
application_server_key_name = "us-east-1-key-pair"

multi_az = false
db_storage_in_gb = 10
db_storage_type = "gp2"
//db_instance_identifier = "demo-mysql-database"
db_engine = "mysql"
db_engine_version = "5.6.40"
db_server_instance_class = "db.t2.micro"
db_name = "demo"
db_username = "john_doe"
db_password = "JohnDoe-2019"
db_port = "3306"
backup_retention_period = "0"
db_backup_window = "02:00-05:30"
db_maintenance_window = "Mon:00:00-Mon:03:00"
db_allow_major_version_upgrade = false
db_allow_minor_version_upgrade  = false
db_parameter_group_name = "default"
db_option_group_name = "default"

s3_bucket_name = "ha-ft-app-storage-59157437841921"