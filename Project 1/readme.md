# 3-tier Web-application

## Description
This project defines a CloudFormation Template that can deploy a 3-tier web app on AWS.

## Architecture
The CloudFormation Template would deploy a stack that would create the following resources:  
1. VPC with public and private subnets.
1. Internet Gateway for the VPC.
1. Security Groups.
1. Application Load Balancer in public subnet.
1. EC2 instances for serving web traffic behind the Application Load Balancer.
1. RDS instance as database server.
1. A bastion host.

## Input Parameters

### Web Servers
AMI Id
Instance Type
Key Pair name