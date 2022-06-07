# Slow writes on S3

Using the default file output committer with S3a results in double data writes (sad times!).
Use a newer cloud committer such as the "S3 magic committer" or a committer specialized for your hadoop cluster. 

Alternatively, write to Apache Iceberg, Delta.io, or Apache Iceberg. 

# References 
[S3 Magic Committer](https://spot.io/blog/improve-apache-spark-performance-with-the-s3-magic-committer/)
[EMRFS S3-optimized Committer](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-spark-committer-reqs.html)
[Apache Iceberg](https://iceberg.apache.org/)
[Delta.io](https://delta.io/)
[Apache Hudi](https://hudi.apache.org/)
