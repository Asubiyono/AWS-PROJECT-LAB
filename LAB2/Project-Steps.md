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
