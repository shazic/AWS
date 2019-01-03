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

output "object_store_id" {
  value = "${aws_s3_bucket.store.id}"
}

output "object_store_arn" {
  value = "${aws_s3_bucket.store.arn}"
}

output "object_store_domain_name" {
  value = "${aws_s3_bucket.store.bucket_domain_name}"
}
