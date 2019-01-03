#####################################################################################################
### storage/outputs.tf
### outputs from the storage layer
#####################################################################################################

##############################
# RDS Instance (DB)
##############################

output "db_endpoint" {
  value = "${aws_db_instance.main.endpoint}"
}

output "rds_instance_id" {
  value = "${aws_db_instance.main.id}"
}
