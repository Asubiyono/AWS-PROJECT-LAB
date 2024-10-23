**Steps**

** 1. Create an S3 bucket **
Link : https://docs.aws.amazon.com/AmazonS3/latest/userguide/GetStartedWithS3.html#creating-bucket 

** 2. Create a Kinesis data stream ** 
Link : https://docs.aws.amazon.com/streams/latest/dev/tutorial-stock-data-kplkcl-create-stream.html 


** 3. Create DynamoDB tables to store aggregated results ** 
, refer to the [AWS DynamoDB documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/getting-started-step-1.html).

&nbsp;&nbsp;&nbsp;&nbsp;Set up three DynamoDB tables, each table will use `trip_id` as the Partition key without a Sort key:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a) **high_value_trips**: Captures trips with total amounts exceeding a set threshold.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b) **trip_duration_analysis**: Stores summaries of trip durations, categorizing them into groups like short, medium, or long.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c) **distance_to_fare_ratio**: Newly added, this table records the fare amount per unit distance, highlighting trip profitability.


4. Create DynamoDB tables to store aggregated results
Link : https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create.html 
a)	Create IAM Policy:
•	Name the policy kinesis-write-records-policy
•	Grant permissions to allow Lambda to write records to the Kinesis stream.

b)	Set Up IAM Role:
•	Name the role lambda-producer-kinesis-role
•	Attach three policies to this role:
o	The kinesis-write-records-policy for write access to Kinesis.
o	AmazonS3ReadOnlyAccess for read-only access to S3
o	AWSLambdaBasicExecutionRole for Lambda to write logs to CloudWatch.
