
mysql --local-infile=1 -h ecommercedb.cfufjsipc6ch.eu-central-1.rds.amazonaws.com -P 3306 -u admin -p

create database ecommerce_db;

use ecommerce_db;

CREATE TABLE orders (
	order_id  int NOT NULL PRIMARY KEY, 
	user_id int NOT NULL, 
	status VARCHAR(15) NOT NULL,
	created_at timestamp NOT NULL, 
	returned_at timestamp default NULL, 
	shipped_at timestamp default NULL,
	delivered_at timestamp default NULL, 
	num_items int NOT NULL
);

CREATE TABLE order_items (
    id  int NOT NULL PRIMARY KEY, 
	order_id  int NOT NULL , 
	product_id int NOT NULL, 
	sales_price decimal not null,
	created_at timestamp NOT NULL
);

CREATE TABLE products (
    id  int NOT NULL PRIMARY KEY, 
	cost  decimal NOT NULL , 
	category VARCHAR(15) NOT NULL,
	name VARCHAR(100) NOT NULL,
	brand VARCHAR(10) NOT NULL,
	department VARCHAR(10) NOT NULL,
	retail_price decimal NOT NULL
);

LOAD DATA LOCAL INFILE "db_files/orders.csv" INTO TABLE ecommerce_db.orders FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "db_files/order_items.csv" INTO TABLE ecommerce_db.order_items FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "db_files/products.csv" INTO TABLE ecommerce_db.products FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;