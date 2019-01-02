#####################################################################################################
### compute/outputs.tf
### outputs from the compute layer
#####################################################################################################

##############################
# EC2 Bastion Hosts
##############################
output "bastion_host_public_ips" {
  value = "${aws_instance.bastion_hosts.*.public_ip}"
}

output "bastion_host_public_dns" {
  value = "${aws_instance.bastion_hosts.*.public_dns}"
}

output "alb_dns" {
  value = "${aws_alb.app.dns_name}"
}

output "auto_scaling_group_arn" {
  value = "${aws_autoscaling_group.app.arn}"
}

output "auto_scaling_group_id" {
  value = "${aws_autoscaling_group.app.id}"
}

output "app_http_target_group_id" {
  value = "${aws_lb_target_group.app_http.id}"
}

output "app_http_target_group_id" {
  value = "${aws_lb_target_group.app_http.id}"
}

output "app_http_listener_id" {
  value = "${aws_lb_listener.app_http.id}"
}

output "app_launch_template_id" {
  value = "${aws_launch_template.app.id}"
}
