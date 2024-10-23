# Project Steps

## 1. Prepare an AWS account for a new custom VPC
Refer to this link: [AWS EC2 Key Pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)  
Remove the default VPC from the AWS account in the current region. To access the EC2 instances that will be created, locate the public IP address for setting up firewall rules.

## 2. Review VPC CloudFormation Template
Refer to these links:  
- [AWS CloudFormation Welcome](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)  
- [Subnet Network ACL Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnetnetworkaclassociation.html)  
- [AWS CloudFormation Subnet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnet.html)  
- [AWS CloudFormation VPC](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpc.html)  

Validate that the template will create two subnets in different Availability Zones and add any necessary configuration to the CloudFormation Template:
- The VPC should be configured with the following CIDR block: `10.0.0.0/16`.
- There should be two subnets in different AZs configured with the following CIDR blocks: `10.0.0.0/24` and `10.0.1.0/24`.
- Interchangeable EC2 instances will be spread across these Availability Zones, and therefore the subnets should have the same routing and security configurations.
- Add any necessary configuration to the CloudFormation Template.

## 3. Troubleshoot CloudFormation Template #1
Attempt to execute CloudFormation Template and resolve any errors until it successfully completes.  
Refer to this: [VPC Gateway Attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcgatewayattachment.html) 

## 4. Verify the results of the CloudFormation Template
Refer to this link: [AWS EC2 Key Pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)  
Confirm that the base VPC has been created along with two public subnets in different Availability Zones. Create an EC2 key pair in the AWS Console. If any elements are missing or incorrect, delete the stack, update the CloudFormation template, and create a new stack.

## 5. Troubleshoot WebApp CloudFormation Template
Refer to this link: [AWS CloudFormation Security Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup.html)  
The WebApp CloudFormation Template is used to create an auto scaling, load balanced group of web servers that run on EC2. Attempt to execute the WebApp CloudFormation Template provided and resolve any errors until it successfully completes.

## 6. Verify CloudFormation Template #2
Verify that the web servers are working properly by connecting to their IP addresses in a web browser. Do not test the Load Balancer, as it may take too long for DNS to propagate.
