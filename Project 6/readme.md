# Highly Available and Fault Tolerant Application on AWS

## Description
This project defines a Terraform Configuration that can deploy a highly available, fault tolerant application on AWS.

## Architecture
The Terraform Configuration would deploy the following resources:  
1. VPC with public and private subnets. The public subnets would be in a separate AZ and so would the private subnets.
1. Private subnets for RDS Instance in separate AZs. The subnet group for RDS would consist of these private subnets.
1. The number of public, private and db subnets is controlled by the user and limited by the number of Availability Zones available in the region.
1. Internet Gateway for the VPC.
1. Application Load Balancer listening to HTTP web traffic and forwarding the requests to the application servers.
1. Bastion hosts in different Availability Zones (if user chooses to launch more than one bastion host).
1. EC2 instances in each of the private subnets (different AZs) as application servers for serving traffic behind the Application Load Balancer.
1. RDS instance in a private subnet to serve as the database server.
1. S3 Bucket as an object store for the application.
1. Security Groups for SSH into bastion host(s), application servers (SSH from bastion host or HTTP/HTTPS from load balancer) and datbase (TCP from application layer only).
1. Auto Scaling Group and Launch Templates for self healing and fault tolerence.

### Architecture Diagram
![Highly-Avaailable and Fault-Tolerant web application](assets/HA-FT-Application.jpg?sanitize=true)
## Input Parameters

### Generic
Project Name
AWS Region
Number of AZs in which application servers would be launched (do not exceed the number of AZs of the given region)

### VPC
VPC CIDR block range 
Public Subnet CIDR blocks
Private Subnet CIDR blocks 
DB Subnet CIDR blocks


### Application Servers
AMI Id  
Instance Size  
Instance Profile to be used (This also requires uncommenting iam_instance_profile under the module compute/main.tf)
Key Pair name for the application servers ec2 instances

### Auto Scaling
Maximum cluster size for the application instances
Minimum cluster size for the application instances
Desired cluster size for the application instances

### Bastion Hosts
AMI Id  
Instance Size  
Number of Bastion hosts to be deployed. If more than one, then they will be deployed in different AZs
Key pair name to SSH into the bastion host
IP CIDR block range from which a user can SSH into the bastion hosts  

### Database Instance
Instance Size  
Storage Class  
Storage Type 
Storage size in GB
Multi-AZ (true or false) 
Database Port
Database Name  
Database Engine
Database Engine Version number  
Database Master User  
Master Password  
Parameter Group Name (This requires uncommenting parameter_group_name in the module storage/main.tf)
Option Group Name (also requires uncommenting option_group_name in the module storage/main.tf)
Backup Retention Period
DB backup window       
DB maintenance window  
Allow major version upgrade
Allow minor version upgrade

### S3
Bucket name (must be a unique name)

## Outputs

See outputs.tf under the root folder to view all outputs. 
Here are a few:

### Bastion Hosts
The public IP Address of the Bastion Hosts.
The public DNS of the Bastion Hosts.

### Application URL
The DNS Name of the Application Load Balancer.

### Database Endpoint
The endpoint to connect to the database in the RDS instance.

### S3
Object store domain name.