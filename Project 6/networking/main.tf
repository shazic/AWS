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
        Name = "${var.project_name}-Public-Subnet-${count.index}"
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
        Name = "${var.project_name}-Private-Subnet-${count.index}"
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
        Name = "${var.project_name}-DB-Subnet-${count.index}"
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

resource "aws_db_subnet_group" "default" {
    name = "terraform-dbsg"
    description = "Subnet group for project ${var.project_name}"
    subnet_ids = ["${aws_subnet.db_private.*.id}"]
    
    tags {
        Name = "${var.project_name}-DB-Subnet-${count.index}"
        Project = "${var.project_name}"
    }
}
