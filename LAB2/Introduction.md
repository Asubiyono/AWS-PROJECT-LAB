## **10. Trigger End-to-End Real-Time Streaming Pipeline**

Refer to the [AWS CloudWatch Logs Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html) and the [AWS DynamoDB Getting Started Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ql-gettingstarted.html).

### Steps:

1. **Upload Data**:  
   Upload the `taxi_trips.csv` file to the S3 bucket, which will trigger the `lambda-kinesis-producer` Lambda function.

2. **Monitor Lambda Function**:  
   Check the activity of the `lambda-kinesis-producer` function via CloudWatch logs under the Logs tab to ensure it runs correctly.

3. **Inspect Kinesis Data Stream**:  
   Navigate to the `taxi_trips` Kinesis data stream and use the Data Viewer. Select a shard and choose the "Trim horizon" option to view incoming JSON payloads.

4. **Verify Lambda Consumer**:  
   Check the `lambda-kinesis-consumer` function’s invocations in CloudWatch Logs to confirm that records are being processed properly.

5. **Query DynamoDB Tables**:  
   Switch to DynamoDB and use PartiQL to query the following tables: `high_value_trips`, `distance_to_fare_ratio`, and `trip_duration_analysis`, ensuring the data is properly ingested and processed throughout the pipeline.
