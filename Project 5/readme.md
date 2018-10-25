# Publishing to two different SQS Queues using an SNS topic

## Description
This project defines a CloudFormation Template that would create an SNS topic that publishes to two separate SQS queues.

## Architecture


### Architecture Diagram
![SNS-SQS](assets/SNS-SQS.jpg?sanitize=true)

## Input Parameters

### Password for SNS Publisher
A new user would be created during the stack creation process that could send messages to the SNS topic. This field would provide a user-provided password for SNS publisher IAM user.

### Password for SQS Consumer
A new user would be created during the stack creation process that could consume the messages from the SQS queues. This field would provide a user-provided password for SQS consumer IAM user.

## Outputs

### ARN for the SNS topic
ARN for the SNS topic created by the stack.

### Queue1 Info
ARN and URL for the SQS Queue 1, created by the stack.

### Queue2 Info
ARN and URL for the SQS Queue 2, created by the stack.

### Topic Publisher IAM User Info
Information about the new user created with permissions to publish to the SNS topic.
- IAM User's ARN
- Access Key
- Secret Access Key

### Queue Consumer IAM User Info
Information about the new user created with permissions to consume messages from the SQS queues.
- IAM User's ARN
- Access Key
- Secret Access Key

