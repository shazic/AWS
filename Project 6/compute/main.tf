#####################################################################################################
### compute/main.tf
### defines the compute layer
#####################################################################################################

# Get the avaialable AZs
data "aws_availability_zones" "available" {}

resource "aws_instance" "bastion_hosts" {
    count = "${var.no_of_azs}"

    ami = "${lookup(var.bastion_host_ami_ids, var.region)}"
    instance_type = "${var.bastion_host_instance_type}"
    key_name = ""
    
    vpc_security_group_ids = [ "${var.bastion_host_security_group_id}" ]
    subnet_id = "${var.public_subnet_ids[count.index]}"

    associate_public_ip_address = "true"


    tags {
        Name = "${var.project_name}-Bastion-Host-${count.index}"
        Project = "${var.project_name}"
    }
}
