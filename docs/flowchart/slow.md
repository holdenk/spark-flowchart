```mermaid
flowchart LR

SlowJob[Slow Job]

SlowJob --> SlowStage[Slow Stage]

SlowStage --> SlowMap[Slow Read/Map]
SlowStage --> SlowReduce[Slow Shuffle/Reducer/Exchange]
SlowJob --> TOOBIGDAG[Too Big DAG]

SlowMap   --> MissingSourcePredicates[Reading more data than needed]
MissingSourcePredicates --> PartitionPruning[Partition Pruning]
MissingSourcePredicates --> ColumnPruning[Column Pruning]
MissingSourcePredicates --> PredicatePushDown[Predicate Push Down]
 
SlowMap   --> TooFewMapTasks[Not enough Read/Map Tasks]
SlowMap   --> TooManyMapTasks[Too many Read/Map Tasks]
SlowMap   --> SlowTransformations[Slow Transformations]
SlowMap   --> SkewedMapTasks[Skewed Map Tasks] 
SkewedMapTasks --> RecordSkew[Record Skew]
SkewedMapTasks --> TaskSkew[Task skew]

SlowReduce --> TooFewShuffleTasks[Not Enough Shuffle Tasks]
SlowReduce --> TooManyShuffleTasks[Too many shuffle tasks]
SlowReduce --> SkewedShuffleTasks[Skewed Shuffle Tasks]
SlowReduce --> SpillToDisk[Spill To Disk]
SkewedShuffleTasks --> SkewedJoin[Skewed Join]
SkewedShuffleTasks --> SkewedAggregation[Aggregation/Group By]
SkewedShuffleTasks --> SkewedWrite[Sort/Rapartition/Coalesce before write]


click SlowJob "../../details/slow-job"
click SlowStage "../../details/slow-stage"
click SlowMap "../../details/slow-map"
click SlowReduce "../../details/slow-reduce"


click MissingSourcePredicates "../../details/slow-map/#reading-more-data-than-needed"
click PartitionPruning "../../details/slow-map/#reading-more-data-than-needed"
click ColumnPruning "../../details/slow-map/#reading-more-data-than-needed"
click PredicatePushDown "../../details/slow-map/#reading-more-data-than-needed"
click TooFewMapTasks "../../details/slow-map/#not-enough-readmap-tasks"
click TooManyMapTasks "../../details/slow-map/#too-many-readmap-tasks"
click SlowTransformations "../../details/slow-map/#slow-transformations"
click SkewedMapTasks "../../details/slow-map/#skewed-map-tasks"
click RecordSkew "../../details/slow-map/#skewed-map-tasks"
click TaskSkew "../../details/slow-map/#skewed-map-tasks"



click TooFewShuffleTasks "../../details/slow-reduce/#not-enough-shuffle-tasks"
click TooManyShuffleTasks "../../details/slow-reduce/#too-many-shuffle-tasks"
click SkewedShuffleTasks "../../details/slow-reduce/#skewed-shuffle-tasks"
click SpillToDisk "../../details/slow-reduce/#spill-to-disk"

click SkewedJoin "../../details/slow-skewed-join"
click SkewedAggregation "../../details/slow-reduce/#skewed-shuffle-tasks"
click SkewedWrite "../../details/slow-skewed-write"


click PAGGS "../../details/partial_aggregates"

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
