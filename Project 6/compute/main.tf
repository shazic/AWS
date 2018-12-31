#####################################################################################################
### compute/main.tf
### defines the compute layer
#####################################################################################################

# Get the avaialable AZs
data "aws_availability_zones" "available" {}

resource "aws_instance" "bastion_hosts" {
    count = "${var.no_of_bastion_hosts}"

    ami = "${lookup(var.bastion_host_ami_ids, var.region)}"
    instance_type = "${var.bastion_host_instance_type}"
    key_name = ""
    
    vpc_security_group_ids = [ "${var.bastion_host_security_group_id}" ]
    subnet_id = "${var.public_subnet_ids[count.index]}"

    associate_public_ip_address = "true"


    tags {
        Name = "${var.project_name}-Bastion-Host-${count.index + 1}"
        Project = "${var.project_name}"
    }
}

resource "aws_alb" "app" {
    name = "${var.project_name}"
    internal = false
    load_balancer_type = "application"
    security_groups = ["${var.load_balancer_security_group_id}"]
    subnets = ["${var.private_subnet_ids}"]

    tags {
        Name = "${var.project_name}-ALB"
        Project = "${var.project_name}"
    }
}

resource "aws_lb_target_group" "app" {
    name = "${var.project_name}-tg"
    
    target_type = "instance"
    port = 80
    protocol = "HTTP"
    vpc_id = "${var.vpc_id}"

    health_check {
        protocol = "HTTP"
        path = "/"
        interval = 30
        timeout = 5
        healthy_threshold = 3
        unhealthy_threshold = 3
        matcher = "200-299"
    }

    tags {
        Name = "${var.project_name}-target-group-http"
        Project = "${var.project_name}"
    }
}
