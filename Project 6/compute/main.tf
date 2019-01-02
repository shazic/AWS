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
    key_name = "${var.bastion_host_key_name}"
    
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
    subnets = ["${var.public_subnet_ids}"]

    enable_cross_zone_load_balancing = true

    tags {
        Name = "${var.project_name}-ALB"
        Project = "${var.project_name}"
    }
}

resource "aws_lb_target_group" "app_http" {
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

resource "aws_lb_listener" "app_http" {
    load_balancer_arn = "${aws_alb.app.arn}"
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = "${aws_lb_target_group.app_http.arn}"
    }
}

resource "aws_launch_template" "app" {
    name = "${var.project_name}-lc"
    image_id = "${lookup(var.application_ami_ids, var.region)}"
    instance_type = "${var.application_server_instance_type}"

    user_data = "${base64encode( "${file("user_data.tpl")}" )}"
    vpc_security_group_ids = ["${var.application_security_group_ids}"]
    
    /*  Currently, HCL does not support conditionally omit a parameter (see https://github.com/hashicorp/terraform/issues/14037).
        If you need to set instance profile, remove # from the below 3 lines.
     */
    # iam_instance_profile {
    #    name = "${var.application_instance_profile}" 
    #} 

    /*  Currently, HCL does not support conditionally omit a parameter (see https://github.com/hashicorp/terraform/issues/14037).
        If you need to set key-pair for app server, remove # from the below line.
     */
    # key_name = "${var.application_server_key_name}"
    

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name = "${var.project_name}-app-server"
        Project = "${var.project_name}"
    }
}

resource "aws_autoscaling_group" "app" {
    name = "${var.project_name}-asg"

    launch_template {
        id = "${aws_launch_template.app.id}"
        version = "$$Latest"
    }

    max_size = "${var.max_application_cluster_size}"
    min_size = "${var.min_application_cluster_size}"
    desired_capacity = "${var.desired_capacity}"

    vpc_zone_identifier = ["${var.public_subnet_ids}"]
    target_group_arns = ["${aws_lb_target_group.app_http.arn}"]

    #termination_policies = []

    tags = [
        {
            key = "Name"
            value = "${var.project_name}-app-server"
            propagate_at_launch = true
        },
        {
            key = "Project"
            value = "${var.project_name}"
            propagate_at_launch = true
        }
    ]
}
