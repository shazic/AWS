# A Pipeline for continuous deployment to a Kubernetes cluster

## Description
This project defines a CloudFormation Template that sets up an AWS CodePipeline for deploying to a Kubernetes cluster using AWS CodeCommit, AWS CodeBuild, Amazon ECR and AWS Lambda.

## Architecture
The CloudFormation Template would deploy the following resources:  
1. A repository with CodeCommit.
1. An AWS CodeBuild Project.
1. An Amazon Lambda function in python that copies a source S3 bucket to a destination.
1. An AWS CodePipeline pipeline to control the flow between the above resources.
1. A CloudWatch Events rule to send notifications to an SNS topic for each status change in the pipeline.
1. An SNS topic for accepting the status change notification from the CodePipeline.


### Architecture Diagram
![pipeline-kubernetes](assets/pipeline-kubernetes.jpg?sanitize=true)

## Input Parameters

### Application Name
- **PipelineName:** A name for your Pipeline 
- **Version:** A version identifier for the Jenkins Build action

### E-mail Subscription
- **Email:** An e-mail id to which all Pipeline state change notifications would be sent. The user has to first confirm the subscription for receiving the e-mails. More users could be added later after the creation of the stack.  

### AWS CodeCommit Repository
- **RepoName:** Name of the source code repository
- **RepositoryDescription:** A short description of the repository

### AWS CodeBuild Project
- **BuildProjectName:** Name of the build project
- **BuildProjectDescription:** A short description of the build project, within 200 characters

### Build Environment
- **ComputeType:** Compute environment for build
- **BuildEnvironmentImage:** Select the run-time environment for the build. (Currently, only Ubuntu Linux environment available for this selection)

## Outputs

### AWS CodeCommit Repository
- The URL to use for cloning the repository over HTTPS.  
- The URL to use for cloning the repository over SSH.  

### Pipeline
- The bucket name that serves as the artifact store of the pipeline.
  
### Notifications
- The arn of the SNS topic that the pipeline sends the state change notifications.
- The CloudWatch Event Rule responsible for sending pipeline state change notifications to the SNS topic.