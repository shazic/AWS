# A CI/CD Pipeline with AWS CodePipeline

## Description
This project defines a CloudFormation Template sets up a CI/CD Pipeline.

## Architecture
The CloudFormation Template would deploy the following resources:  
1. A repository with CodeCommit.
1. An EC2 server which has Jenkins installed. The Jenkins server would interact with AWS CodePipeline as the SCM and would delegate build tasks to an AWS CodeBuild project.
1. An AWS CodeBuild Project.
1. An AWS CodeDeploy application and deployment group
1. An AWS CodePipeline pipeline to control the flow between the above resources.

## Input Parameters

### Application Name
A name for your Pipeline.  

### Jenkins Server
AMI Id  
Instance Size  
Key Pair name  

## Outputs

### Jenkins Server
The public IP Address of the Jenkins server.