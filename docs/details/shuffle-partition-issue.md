# Partitioning at the shuffle phase

Partitioning problems are often the limitation of parallelism for most Spark jobs.

There are two primary types of bad partitioning, skewed partitioning (where the partitions are not equal in size/work) or even but non-ideal number partitioning (where the partitions are equal in size/work). If your tasks are taking roughly equivalent times to complete then you likely have even partitioning, and if they are taking unequal times to complete then you may have skewed or uneven partitioning.


