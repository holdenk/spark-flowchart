# Prefer Netflix SQL Functions

Netflix has added the follow categories of SQL functions that support both Spark and Presto.

Category | Spark Doc | Presto Doc
-------- | --------- | ----------
Date | [link](https://manuals.netflix.net/view/sparkdocs/mkdocs/master/netflixdateudfs/) | [link](https://manuals.netflix.net/view/Presto/mkdocs/master/netflixdateudfs/)
JSON | [link](https://manuals.netflix.net/view/sparkdocs/mkdocs/master/netflixjsonudfs/) | [link](https://manuals.netflix.net/view/Presto/mkdocs/master/netflixjsonudfs/)
Histogram | [link](https://manuals.netflix.net/view/sparkdocs/mkdocs/master/netflixhistogram/) | [link](https://manuals.netflix.net/view/Presto/mkdocs/master/NetflixHistogram/)

It is recommended to use these SQL functions instead of native Spark functions:

- The SQL query is portable
- The view using these functions are portable
