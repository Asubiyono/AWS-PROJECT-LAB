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
   
## **5. Upload CSV Files to EC2**

1. Upload the CSV files to the EC2 instance. These files contain the data for the MySQL tables.

2. Create a folder named `db_files` in the root directory of the EC2 instance.

3. Use the SCP command to upload the three CSV files from the local system to the `db_files` folder on the EC2 instance.

## **6. Modify Security Group for the MySQL Instance**

1. Modify the inbound settings of the Security Group for the MySQL RDS instance to enable connections from the EC2 instance.
   
2. Locate the RDS MySQL instance and open the **Connectivity and Security** tab.

3. Identify the **Security Group** associated with the instance.

4. Modify the Security Group to allow public access to **TCP port 3306** for MySQL/Aurora.

## **7. Create Database Tables and Load Data into MySQL DB**

1. Connect to the MySQL RDS instance from the EC2 instance by executing the SSH command in your local terminal.

2. Once connected to the EC2 instance, access the MySQL instance to create a database and execute the DDL statements for the required tables.

3. After creating the database and tables in the MySQL RDS instance, ingest data from the CSV files located in the `db_files` directory on the EC2 instance.

## **8. Create a Secret in AWS Secrets Manager for MySQL DB Credentials**

1. Create a new secret in AWS Secrets Manager to store the MySQL database credentials for the RDS instance `ecommerce-db`. This secret will be accessed dynamically by the Python Flask scripts.

2. The secret should contain four parameters:
   - **host**: The endpoint of the MySQL RDS instance.
   - **username**: The username for the database (e.g., `admin`).
   - **password**: The password you set for the MySQL database.
   - **db_name**: Set this parameter to `ecommerce_db`.

3. **Note**: Include the new key called `db_name` in the secret to hold the MySQL database name.
   
## **9. Create IAM Role for Secrets Manager**

To grant the Python/Flask scripts running on EC2 access to the secret created earlier, follow these steps:

1. **Create a new IAM role** named `EC2_SECRETS_MANAGER_ROLE`.

2. **Attach a permission policy** to this role that allows read access to AWS Secrets Manager. The policy should include permissions for actions such as:
   - `secretsmanager:GetSecretValue`
   - `secretsmanager:DescribeSecret`

3. **Attach the role** to the EC2 instance running the Python/Flask application to enable access to the secret.

## **10. Assign the IAM Role to the EC2 Instance**

To assign the IAM role created previously to the EC2 instance, follow these steps:

1. **Navigate to the EC2 Dashboard** in the AWS Management Console.

2. **Select your EC2 instance** that is running the Python/Flask application.

 ## **11. Modify Configuration in Python/Flask Scripts**

To ensure your Python/Flask application can access the MySQL database credentials stored in AWS Secrets Manager, update the following parameters in your scripts:

1. **Locate the relevant section in your Flask application** where you establish database connectivity.

2. **Update the following parameters**:
   - **secret_name**: Set this to the name of the secret you created in Secrets Manager that contains your MySQL credentials (e.g., `ecommerce-db-credentials`).
   - **region**: Specify the AWS region where your secret is stored (e.g., `us-east-1`).

4. **Click on the “Actions” dropdown menu**, then hover over "Security" and select "Modify IAM Role."

5. **In the IAM Role dropdown**, choose the newly created role (`EC2_SECRETS_MANAGER_ROLE`) from the list of available roles.

6. **Click on the “Update IAM Role” button** to save the changes.
