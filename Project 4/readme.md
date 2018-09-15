# Docker Containers setup on AWS

## Description
This project defines a CloudFormation Template that sets up an AWS architecture for Docker Enterprise Edition (EE) and deploys it.

## Architecture
The CloudFormation Template would deploy the following resources:  
1. A virtual private cloud (VPC).
1. Three Availability Zones that include three public subnets.
1. Three ELBs for serving traffic to DTR, UCP and the Swarm.
1. An Auto scaling group for the Swarm.
1. A Launch Configuration for the ASG
1. EC2 instances for the Swarm, DTR and UCP.
1. Amazon S3 bucket for the root certificate.


### Architecture Diagram
![docker-enterprise-edition-architecture](assets/docker-enterprise-edition-architecture.jpg?sanitize=true)

## Input Parameters

### Swarm Size
- **ManagerSize:** Number of Swarm Managers 
- **ClusterSize:** Number of Swarm worker nodes

### Swarm
- **KeyName:** Name of an existing EC2 public/private keypair to enable SSH access to the instances.  
- **RemoteSSH:** IP address range that can SSH to the EC2 instance.  
- **EnableSystemPrune:** Enable daily resource cleanup.  
- **EnableCloudWatchLogs:** Use CloudWatch for container logging.  

### Swarm Manager
- **ManagerInstanceType:** Swarm manager instance type.  
- **ManagerDiskSize:** Manager storage volume size in GiB.  
- **ManagerDiskType:** Manager storage volume type (gp2/io1/st1).

### Swarm Worker
- **InstanceType:** Worker instance type.  
- **WorkerDiskSize:** Worker storage volume size in GiB.  
- **WorkerDiskType:** Worker storage volume type (gp2/io1/st1).

### HTTP Proxy
- **HTTPProxy:** Value for HTTPS_PROXY environment variable.  
- **NoProxy:** Value for NO_PROXY environment variable.  

### Docker Enterprise Edition
- **DDCUsernameSet:** Set a username for Docker EE.  
- **DDCPasswordSet:** Set a password for Docker EE.  
- **License:** Docker EE license in JSON format.  

## Outputs

### Docker EE
- Docker EE Username.  
- Docker EE DTR Login URL.  

### DNS Properties  
- Default DNS target.  
- Elastic Load Balancer's zone id.  

### Swarm
- Manager Security Group Id.  
- Manager node URL.  
- Node Security Group Id.  
- Swarm security Group id.  

### Universal Control Plane  
- Docker EE UCP Login URL.  

### Network  
- VPC Id.  
- Availability Zones recommendation based on region.