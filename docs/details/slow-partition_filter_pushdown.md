# Partition Filters

Processing more data than necessary will typically slow down the job. 
If the input table is partitioned then applying filters on the partition columns can restrict the input volume Spark
 needs
 to scan.


A simple equality filter gets pushed down to the batch scan and enables Spark to only scan the files 
where `dateint = 20211101` of a sample table partitioned on `dateint` and `hour`.

```
select *
from jlantos.sample_table
where dateint = 20211101
limit 100
```
![Successful-Filter_Pushdown](../imgs/spark-filter-pushdown-success.png)

### Examples when the filter does not get pushed down

#### The filter contains an expression 

If instead of a particular date we'd like to load data from the 1st of any month we might
 rewrite the above query such as:

```
select *
from jlantos.sample_table
where dateint % 100 = 1
limit 100
```

The query plan shows that Spark in this case scans the whole table and filters only in a later step.

![Successful-Filter_Pushdown](../imgs/spark-filter-ignored.png)


### Filter is dynamic via a join

In a more complex job we might restrict the data based on joining to another table. If the filtering criteria is not
 static it won't be pushed down to the scan. So in the example below the two table scans happen independently, and
  `min(dateint)` calculated in the CTE won't have an effect on the second scan.

```
with dates as
  (select min(dateint) dateint
   from jlantos.sample_table)

select *
from jlantos.sample_table st
join dates d on st.dateint = d.dateint
```
