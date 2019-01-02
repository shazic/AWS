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
