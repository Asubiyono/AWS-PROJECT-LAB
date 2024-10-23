## **Steps**

## **1. Create an S3 bucket**  
Refer to the [AWS S3 documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/GetStartedWithS3.html#creating-bucket).


## **2. Create a Kinesis data stream**  
Refer to the [AWS Kinesis data stream documentation](https://docs.aws.amazon.com/streams/latest/dev/tutorial-stock-data-kplkcl-create-stream.html).

## **3. Create DynamoDB tables to store aggregated results**

Refer to the [AWS DynamoDB documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/getting-started-step-1.html).

&nbsp;&nbsp;&nbsp;&nbsp;Set up three DynamoDB tables, each table will use `trip_id` as the Partition key without a Sort key:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a) **high_value_trips**: Captures trips with total amounts exceeding a set threshold.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b) **trip_duration_analysis**: Stores summaries of trip durations, categorizing them into groups like short, medium, or long.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c) **distance_to_fare_ratio**: Newly added, this table records the fare amount per unit distance, highlighting trip profitability.

## **4. Create DynamoDB tables to store aggregated results**
Refer to the [AWS IAM Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create.html)

&nbsp;&nbsp;&nbsp;&nbsp;a) **Create IAM Policy**:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• Name the policy `kinesis-write-records-policy`  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• Grant permissions to allow Lambda to write records to the Kinesis stream.  

&nbsp;&nbsp;&nbsp;&nbsp;b) **Set Up IAM Role**:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• Name the role `lambda-producer-kinesis-role`  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• Attach three policies to this role:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;o The `kinesis-write-records-policy` for write access to Kinesis.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;o `AmazonS3ReadOnlyAccess` for read-only access to S3  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;o `AWSLambdaBasicExecutionRole` for Lambda to write logs to CloudWatch.

## **5. Create IAM Role for Kinesis consumer Lambda Function**

&nbsp;&nbsp;&nbsp;&nbsp;a) **Create 2 IAM Policies**:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• The first policy `lambda-kinesis-read-policy`:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→ Grant permissions to allow the Lambda function to read from the Kinesis Data Stream, including `GetRecords` and `DescribeStream`.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• The second policy `lambda-dynamo-write-policy`:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→ Grant permissions to allow the Lambda function to write to DynamoDB, allowing actions such as `PutItem` and `UpdateItem`.  

&nbsp;&nbsp;&nbsp;&nbsp;b) **Create IAM Role `lambda-kinesis-streams-consumer-role`**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Attach the following policies:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• `lambda-kinesis-read-policy`  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• `lambda-dynamo-write-policy`  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• `AWSLambdaBasicExecutionRole`:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→ This role is essential for your Lambda function, enabling it to read data from your Kinesis stream and write the processed information to DynamoDB, while ensuring the function has basic execution permissions, like writing logs to CloudWatch.

## **6. Develop Producer Lambda Function to Write Data into Kinesis**

### File: `lambda-kinesis-producer.py`

Write a Python script for a Lambda function to read data from an S3 bucket and send it to a Kinesis stream. The function will be triggered by an S3 event and deployed to AWS Lambda.

### Steps:

1. **Initialization**:  
   Set up AWS services and configure logging for capturing essential information and errors.

2. **Handle S3 Event**:  
   Extract file name and bucket details from the event trigger.

3. **Read from S3**:  
   Retrieve and read the taxi trip data from the specified S3 bucket.

4. **Process Data**:  
   Parse and format the data for further processing.

5. **Send to Kinesis**:  
   Stream processed records to the `taxi_trips` Kinesis stream.

6. **Error Handling**:  
   Implement proper error management and logging throughout the process.

## **7. Develop Consumer Lambda Function to Consume Streaming Data from Kinesis**

### File: `lambda-kinesis-consumer.py`

Write a Python script for a Lambda function to consume and process taxi trip data from the `taxi_trips` Kinesis data stream, with Kinesis as the trigger. The function will be deployed to AWS Lambda.

### Implementation Steps:

1. **Import Necessary Modules**:  
   Start by importing the required libraries for AWS services, data processing, and logging.

2. **Set Up Configurations**:  
   Configure any necessary settings for calculations and logging.

3. **Define Key Functions**:
   - **Calculate Trip Durations**:  
     Implement a function to calculate the duration of each trip.
   - **Generate/Retrieve Trip IDs**:  
     Create a function to generate or retrieve unique trip IDs for data records.
   - **Calculate Fare per Distance Unit**:  
     Develop a function to compute fare based on the distance traveled.

4. **Write the Lambda Handler Function**:  
   - Connect to DynamoDB.
   - Process data records received from Kinesis.
   - Categorize trips based on value, duration, and fare efficiency.
   - Store the analysis outcomes in DynamoDB for automated data processing and insights.

## **8. Deploy Consumer Lambda Function**

Refer to the [link](https://docs.aws.amazon.com/lambda/latest/dg/lambda-python.html) for AWS Lambda Python documentation.

Use the code from `lambda-kinesis-consumer.py`, then set up and activate a Kinesis trigger to handle data from the `taxi_trips` stream.

## **9. Deploy Producer Lambda Function**

Use the code from `lambda-kinesis-producer.py`, then set up and activate an S3 trigger to write data into the `taxi_trips` Kinesis data stream from a CSV file in the S3 bucket.


