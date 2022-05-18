# Partitioning

Partitioning problems are often the limitation of parallelism for most Spark jobs.

There are two primary types of bad partitioning, skewed partitioning (where the partitions are not equal in size/work) or even but non-ideal number partitioning (where the partitions are equal in size/work). If your tasks are taking roughly equivalent times to complete then you likely have even partitioning, and if they are taking unequal times to complete then you may have skewed or uneven partitioning.


We're used to thinking of partitioning after a shuffle, but partitioning problems can occur at read time as well. This often happens when the layout of the data on disk is not well suited to our computation.
