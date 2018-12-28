# Highly Available and Fault Tolerant Application on AWS

## Description
This project defines a Terraform Configuration that can deploy a highly available, fault tolerant application on AWS.

## Architecture
The Terraform Configuration would deploy the following resources:  
1. VPC with 2 public and 2 private subnets. The two public subnets would be in a separate AZ and so would the two private subnets.
1. Two private subnets for RDS Instance in separate AZs.
1. Internet Gateway for the VPC.
1. Security Groups.
1. Application Load Balancer listening to HTTP web traffic and forwarding the requests to the application servers.
1. Two EC2 instances in private subnets (different AZs) as application servers for serving traffic behind the Application Load Balancer.
1. Auto Scaling Group and Launch Templates for self healing and fault tolerence upto one Availability Zone.
1. RDS instance in a private subnet to serve as the database server.
1. Two bastion hosts in 2 Availability Zones.

### Architecture Diagram
![Highly-Avaailable and Fault-Tolerant web application](assets/HA-FT-Application.jpg?sanitize=true)
## Input Parameters

### VPC
VPC CIDR block range  

### Application Servers
AMI Id  
Instance Size  
Key Pair name  

### Bastion Hosts
AMI Id  
Instance Size  
IP CIDR block range from which a user can SSH into the bastion hosts  
The bastion hosts would use the same Key Pair as the application servers  

### Database Instance
Instance Size  
Storage Class  
Storage Type  
Database Name  
Database Engine  
Database Master User  
Master Password  

## Outputs

### Bastion Hosts
The public IP Address of the Bastion Hosts.

### Application URL
The DNS Name of the Application Load Balancer.

### Database Endpoint
The endpoint to connect to the database in the RDS instance.

### Application Servers
Private IP addresses of the application servers.