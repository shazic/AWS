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
1. A CloudWatch Events rule to send notifications to an SNS topic for each status change in the pipeline.
1. An SNS topic for accepting the status change notification from the CodePipeline.

## Input Parameters

### Application Name
- **PipelineName:** A name for your Pipeline 
- **Version:** A version identifier for the Jenkins Build action

### AWS CodeCommit Repository
- **RepoName:** Name of the source code repository
- **RepositoryDescription:** A short description of the repository

### Jenkins Server
- **VPCCidrBlock:** VPC CIDR block for the VPC to be created
- **ImageId:** An AMI with Jenkins installed along with the plugins for AWS Pipeline and AWS CodeBuild.
- **InstanceType:** Instance size of the Jenkins server
- **KeyName:** A key-pair to connect to the Jenkins server
- **CidrRange:** An IP CIDR range from which the Jenkins server could be accessed through port 8080
- **JenkinsProject:** Jenkins project name
- **JenkinsProvider:** The provider name in the Jenkins Project for the Build stage

### AWS CodeBuild Project
- **BuildProjectName:** Name of the build project
- **BuildProjectDescription:** A short description of the build project, within 200 characters

### Build Environment
- **ComputeType:** Compute environment for build
- **BuildEnvironmentImage:** Select the run-time environment for the build. (Currently, only Ubuntu Linux environment available for this selection)

### AWS CodeDeploy Application
- **DeploymentKeyName:** The Tag's keyname of the ec2 instances on which deployment would occur
- **DeploymentKeyValue:** The Tag's key value of the ec2 instances on which deployment would occur

## Outputs

### AWS CodeCommit Repository
- The URL to use for cloning the repository over HTTPS.  
- The URL to use for cloning the repository over SSH.  
  
### Jenkins Server
- The public IP Address of the Jenkins server.  
- The URL to access the Jenkins server.  