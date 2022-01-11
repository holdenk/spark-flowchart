# Tables getting broadcasted even when broadcast is disabled

You expect the broadcast to stop after you disable the broadcast threshold, by setting ```spark.sql.autoBroadcastJoinThreshold``` to -1, but Spark tries to broadcast the bigger table and fails with a broadcast error. And you observe that the query plan has BroadcastNestedLoopJoin in the physical plan.
 
*  Check for sub queries in your code using ```NOT IN```  

Example : 

    select * from TableA where id not in (select id from TableB)  

This typically results in a forced BroadcastNestedLoopJoin even when the broadcast setting is disabled.
If the data being processed is large enough, this results in broadcast errors when Spark attempts to broadcast the table

* Rewrite query using ```not exists``` or a regular ```LEFT JOIN``` instead of ```not in```

Example:

    select * from TableA where not exists (select 1 from TableB where TableA.id = TableB.id)

The query will use SortMergeJoin and will resolve any Driver memory errors because of forced broadcasts


#Relevant links

[External Resource](https://kb.databricks.com/sql/disable-broadcast-when-broadcastnestedloopjoin.html)
