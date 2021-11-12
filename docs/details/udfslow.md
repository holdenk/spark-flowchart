# Avoid UDFs for the most part

User defined functions in Spark are [black blox](https://jaceklaskowski.gitbooks.io/mastering-spark-sql/content/spark-sql-udfs-blackbox.html) to Spark and can limit performance. When possible look for [built-in](https://spark.apache.org/docs/latest/api/sql/index.html) alternatives.


One important exception is that if you have multiple functions which *must be* done in Python, the advice changes a little bit. Since moving data from the JVM to Python is expensive, if you can chain together multiple Python UDFs on the same column, Spark is able to pipeline these together into a single copy to/from Python.
