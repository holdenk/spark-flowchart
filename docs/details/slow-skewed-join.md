# Skewed Joins

Skewed joins happen frequently as some locations (NYC), data (null), and titles ([Mr. Farts - Farting Around The House](https://amzn.to/3I58SiG)) are more popular than other types of data.


To a certain degree Spark 3.3 query engine has improvements to handle skewed joins, so a first step should be attempting to upgrade to the most recent version of Sprk.


Broadcast joins are ideal for handling skewed joins, _but_ they only work when one table is smaller than the other. A general, albiet hacky, solution is to isolate the data for the skewed key, broadcast it for processing (e.g. join) and then union back the results.


Other technique can include introduce some type of salting and doing multi-stage joins.



