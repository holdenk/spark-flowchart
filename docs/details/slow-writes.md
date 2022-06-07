# Slow Writes

The Shuffle Write time is visible from the Spark UI --> Stages Tab --> Stages Detail --> Event timeline. 
Symptom: my spark job is spending more time writing files to disk on shuffle writes.

Some potential causes: 
  - the job is writing too many files
  - the file output committer is not suited for this many writes

Let's investigate further by considering a few file output committers. 
