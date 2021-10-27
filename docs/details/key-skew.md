# Key/Partition Skew

Key or partition skew is a frequent problem in Spark. Key skew can result in everything from slowly running jobs (with straglers), to failing jobs.


The first step to understanding key-skew is to understand Spark's partioning...


Certain types of aggregations and windows can result in partioning the data on a particular key.
