## **Project Steps**

## **1. Set Up a MySQL Database on AWS RDS**

Refer to this [AWS RDS Setup Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Tutorials.WebServerDB.CreateDBInstance.html) to set up a MySQL 8.0.32 instance on AWS RDS as the transactional database for the microservices.

### **Key Configuration**:
- **Template**: Dev/Test with Multi-AZ  
- **DB Identifier**: `ecommerce-db`  
- **Username**: `admin` (set password of your choice)  
- **Instance Type**: Burstable (`db.t3.micro`)  
- **Storage**: 20GB `gp2`  
- **Network**: Default VPC/Subnet, allow public access  
- **Authentication**: Password-based  

## **2. Create an EC2 Instance**

Refer to this [AWS EC2 Getting Started Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html) for detailed instructions.

### **Key Steps**:
1. Set up an EC2 instance on **Ubuntu 20.04 LTS** for deploying a Python/Flask backend.
2. Name the instance `ecommerce_backend` and select `t2.micro` as the instance type.
3. Create a new **Key-pair** and save it locally.
4. Set up a **Security Group** to allow SSH (22), HTTP (80), and HTTPS (443) traffic from anywhere.
5. Configure storage to **8GB**.
6. Launch the instance.

## **3. Install SSH & SCP on Your Local System**

Refer to this [guide on using the SCP command on Windows](https://success.tanaza.com/s/article/How-to-use-SCP-command-on-Windows) for detailed instructions.

SSH and SCP must be installed on the local computer to log in to the EC2 instance and copy files from the local system to the EC2 server using SSH and SCP commands.

## **4. Install Dependencies on EC2**

1. Connect to the EC2 instance via SSH using the `.pem` file from your local terminal.
2. Install the following libraries:
   - `python3-pip`
   - `default-libmysqlclient-dev`
   - `python3-flask`
   - `flask-mysql`
   - `pkg-config`
   - `flask-mysqldb`
   - `boto3`

3. After the installation, create a folder named `ecommerce_app` in the root directory to store the Python/Flask scripts for future steps.

