# Write Fails

Write failures can sometimes mask other problems. A good first step is to insert a cache or persist right before the write step.


Iceberg table writes can sometimes fail after upgrading to a new version as the partioning of the table bubbles further up. Range based partioning (used by default with sorted tables) can result in a small number of partions when there is not much key distance.


One option is to, as with a manual sort in Spark, add some extra higher cardinality columns to your sort order in your iceberg table.


You can go back to pre-Spark 3 behaviour by instead insert your own manual sort and set write mode to `none`.
