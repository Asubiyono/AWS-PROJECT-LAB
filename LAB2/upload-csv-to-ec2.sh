# Change the permissions of the pem file
chmod 400 file-name.pem

# Connect to Ec2 and create a folder : db_files inside the EC2 Instance
ssh -i "file-name.pem" ubuntu@public-ipv4-dns.com
mkdir db_files
exit

# Upload the CSV Files to EC2 instance from your local system 
scp -i "file-name.pem" mysql-data/order_items.csv ubuntu@public-ipv4-dns.com:db_files/
scp -i "file-name.pem" mysql-data/orders.csv ubuntu@public-ipv4-dns.com:db_files/
scp -i "file-name.pem" mysql-data/products.csv ubuntu@public-ipv4-dns.com:db_files/