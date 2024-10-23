# 🌐 Automate Load Balancer and VPC Creation using CloudFormation

## Project Objective 🎯
This project involves migrating key modules of an e-commerce startup's application from a monolithic architecture to a microservice-oriented architecture. The goal is to deploy each module as an independent microservice using Flask, running on EC2, with a MySQL database hosted on RDS. The migration will ensure scalability and secure database access.

In this lab scenario, the role of a solutions architect involves creating efficient methods for multiple load-balanced EC2 deployments. A new version of an e-commerce application is set to be released next month, necessitating identical Test, Dev, and Production environments. Existing CloudFormation templates, created by a consultant, are not functioning properly and need to be reviewed and corrected.

## Key Tasks 🛠️
1. **Review and correct CloudFormation templates** to ensure successful deployment of the necessary resources for the application.
  
2. **First Template:**
   - 🌐 Create a network environment for the application by setting up a VPC with two public subnets located in different Availability Zones (AZs).
   - 🌍 Ensure both subnets have a default route that allows traffic to the Internet.

3. **Second Template:**
   - ⚙️ Deploy an Auto Scaling group of web servers behind a load balancer.
   - 🔗 Ensure instances are spread across AZs and accessible from the Internet over HTTP (port 80).
   - 🏗️ Configure instances to self-launch and run a script that creates a simple website.
