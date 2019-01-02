#####################################################################################################
### networking/main.tf
### defines the network layer
#####################################################################################################

# Get the avaialable AZs
data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "this" {
    cidr_block = "${var.cidr_block}"
    
    tags {
        Name = "${var.project_name}-VPC"
        Project = "${var.project_name}"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
    vpc_id = "${aws_vpc.this.id}"

    tags {
        Name = "${var.project_name}-IGW"
        Project = "${var.project_name}"
    }
}

# Adopt the default route table as the private route
resource "aws_default_route_table" "private" {
    default_route_table_id = "${aws_vpc.this.default_route_table_id}"

    tags {
        Name = "${var.project_name}-Private-Route-Table"
        Project = "${var.project_name}"
    }
}

# Route Table for Public Route
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.this.id}"

    tags {
        Name = "${var.project_name}-Public-Route-Table"
        Project = "${var.project_name}"
    }
}

# Public Route
resource "aws_route" "public" {
    route_table_id = "${aws_route_table.public.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
}

# Public Subnets
resource "aws_subnet" "public" {
    count = "${var.no_of_azs}"
    vpc_id = "${aws_vpc.this.id}"
    cidr_block = "${var.public_subnet_cidr_blocks[count.index]}"
    map_public_ip_on_launch = true
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    
    tags {
        Name = "${var.project_name}-Public-Subnet-${count.index + 1}"
        Project = "${var.project_name}"
    }

    depends_on = ["aws_route_table.public"]
}

# Private Subnets
resource "aws_subnet" "private" {
    count = "${var.no_of_azs}"
    vpc_id = "${aws_vpc.this.id}"
    cidr_block = "${var.private_subnet_cidr_blocks[count.index]}"
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    
    tags {
        Name = "${var.project_name}-Private-Subnet-${count.index + 1}"
        Project = "${var.project_name}"
    }
}

# Database Subnets (Private)
resource "aws_subnet" "db_private" {
    count = "${var.no_of_azs}"
    vpc_id = "${aws_vpc.this.id}"
    cidr_block = "${var.db_subnet_cidr_blocks[count.index]}"
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    
    tags {
        Name = "${var.project_name}-DB-Subnet-${count.index + 1}"
        Project = "${var.project_name}"
    }
}

# Associate public route table to subnets created to be public
resource "aws_route_table_association" "public" {
    count = "${aws_subnet.public.count}"
    subnet_id = "${aws_subnet.public.*.id[count.index]}"
    route_table_id = "${aws_route_table.public.id}"
}

# Associate private route table to private subnets
resource "aws_route_table_association" "private" {
    count = "${aws_subnet.private.count}"
    subnet_id = "${aws_subnet.private.*.id[count.index]}"
    route_table_id = "${aws_default_route_table.private.id}"
}

# Associate private route table to db subnets
resource "aws_route_table_association" "db_private" {
    count = "${aws_subnet.db_private.count}"
    subnet_id = "${aws_subnet.db_private.*.id[count.index]}"
    route_table_id = "${aws_default_route_table.private.id}"
}

# DB Subnet group
resource "aws_db_subnet_group" "default" {
    name = "terraform-dbsg"
    description = "Subnet group for project ${var.project_name}"
    subnet_ids = ["${aws_subnet.db_private.*.id}"]
    
    tags {
        Name = "${var.project_name}-DB-Subnet"
        Project = "${var.project_name}"
    }
}

# Security Groups
# 1 - Security group for the bastion host in public subnet
resource "aws_security_group" "bastion_host" {
    name = "bastion_host_sg"
    description = "Allow ingress from specific IP addresses"
    vpc_id = "${aws_vpc.this.id}"

    ingress {
        description = "Allow SSH traffic from specific IP addresses"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["${var.allowed_ips}"]
    }

    egress {
        description = "Allow traffic out from all ports on all protocols to anywhere"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "${var.project_name}-bastion-host-SG"
        Project = "${var.project_name}"
    }
}
# 2 - Security group for accepting web traffic
resource "aws_security_group" "open_internet" {
    name = "web_traffic_ingress"
    description = "web traffic"
    vpc_id = "${aws_vpc.this.id}"

    ingress {
        description = "Allow all HTTP traffic from open internet"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow all HTTPS traffic from open internet"
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow traffic out from all ports on all protocols to anywhere"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "${var.project_name}-web-SG"
        Project = "${var.project_name}"
    }
}
# 3 - Security group for the application layer in private subnet
resource "aws_security_group" "application_server" {
    name = "app_server_sg"
    description = "Allow ingress from the load balancer only"
    vpc_id = "${aws_vpc.this.id}"

    ingress {
        description = "Allow ingress from the load balancer only"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        security_groups = [ "${aws_security_group.open_internet.id}" ]
    }
    ingress {
        description = "Allow secure ingress from the load balancer only"
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        security_groups = [ "${aws_security_group.open_internet.id}" ]
    }
    ingress {
        description = "Allow ingress from the bastion host"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        security_groups = [ "${aws_security_group.bastion_host.id}" ]
    }
    egress {
        description = "Allow traffic out from all ports on all protocols to anywhere"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "${var.project_name}-Application-SG"
        Project = "${var.project_name}"
    }
}
# 4 - DB security group 
resource "aws_security_group" "db" {
    name = "db_sg"
    description = "Allow ingress from the application server only"
    vpc_id = "${aws_vpc.this.id}"

    ingress {
        description = "Allow ingress from the application server only"
        from_port = "${var.db_port}"
        to_port = "${var.db_port}"
        protocol = "tcp"
        security_groups = [ "${aws_security_group.application_server.id}" ]
    }
    egress {
        description = "Allow traffic out from all ports on all protocols to anywhere"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "${var.project_name}-DB-SG"
        Project = "${var.project_name}"
    }
}
