-- create stream from topic
CREATE stream samplestream (itemid VARCHAR, orderid INTEGER) WITH (kafka_topic='sample_data', value_format = 'JSON_SR');

-- create stream from topic
CREATE STREAM users  (id INTEGER KEY, gender STRING, name STRING, age INTEGER) WITH (kafka_topic='users', partitions=1, value_format='JSON');

-- emit changes from stream
SELECT *  FROM samplestream EMIT CHANGES;

-- create table with declared columns: 
CREATE TABLE table1 (
     itemid INT PRIMARY KEY,
     orderid INT
   ) WITH (
     KAFKA_TOPIC = 'sample_data', 
     VALUE_FORMAT = 'JSON_SR'
);