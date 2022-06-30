# spark.sql.AnalysisException: Correlated column is not allowed in predicate

SPARK-35080 introduces a check for correlated subqueries with aggregates which may have previously return incorect results.
Instead, starting in Spark 2.4.8, these queries will raise an `org.apache.spark.sql.AnalysisException` exception.

One of the examples of this ([from the JIRA](https://issues.apache.org/jira/browse/SPARK-35080?page=com.atlassian.jira.plugin.system.issuetabpanels%3Aall-tabpanel)) is:

```sql
create or replace view t1(c) as values ('a'), ('b');
create or replace view t2(c) as values ('ab'), ('abc'), ('bc');

select c, (select count(*) from t2 where t1.c = substring(t2.c, 1, 1)) from t1;
```

Instead you should do an explicit join and then perform your aggregation:


```sql
create or replace view t1(c) as values ('a'), ('b');
create or replace view t2(c) as values ('ab'), ('abc'), ('bc');

create or replace view t3 as select t1.c from t2 INNER JOIN t1 ON t1.c = substring(t2.c, 1, 1);

select c, count(*) from t3 group by c;
```

Similarly:

```sql
create or replace view t1(a, b) as values (0, 6), (1, 5), (2, 4), (3, 3);
create or replace view t2(c) as values (6);

select c, (select count(*) from t1 where a + b = c) from t2;
```

Can be rewritten as:

```sql
create or replace view t1(a, b) as values (0, 6), (1, 5), (2, 4), (3, 3);
create or replace view t2(c) as values (6);

create or replace view t3 as select t2.c from t2 INNER JOIN t1 ON t2.c = t1.a + t1.b;

select c, count(*) from t3 group by c;
```

Likewise in Scala and Python use an explicit `.join` and then perform your aggregation on the joined result.
Now Spark can compute correct results thus avoiding the exception.


# Relevant links:

- [SPARK-35080 JIRA](https://issues.apache.org/jira/browse/SPARK-35080)
- [Stackoverflow discussion for PySpark workaround of Correlated Column](https://stackoverflow.com/questions/65358584/pyspark-error-while-running-sql-subquery-analysisexception-ucorrelated-column)
