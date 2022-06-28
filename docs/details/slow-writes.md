# Slow Writes

The Shuffle Write time is visible as follows:

Spark UI --> Stages Tab --> Stages Detail --> Event timeline. 

Symptom: my spark job is spending more time writing files to disk on shuffle writes.

Some potential causes: 

  * [the job is writing too many files](./slow-writes-too-many-files.md)

  * [the job is writing skewed files](./slow-skewed-write.md)

  * the [file output committer](./slow-writes-s3.md) is not suited for this many writes

