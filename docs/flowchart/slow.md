```mermaid
flowchart LR

SlowJob[Slow Job]

SlowJob --> SlowStage[Slow Stage]

SlowStage --> SlowMap[Slow Read/Map]
SlowStage --> SlowReduce[Slow Shuffle/Reducer/Exchange]
SlowStage --> SLOWWRITESTOSTORAGE[Slow writes to storage]

SlowJob --> TOOBIGDAG[Too Big DAG]

SlowMap --> SLOWEXEC[Slow executor]
EVENPART_SLOW --> UDFSLOWNESS[Slow UDF]
SlowReduce --> PAGGS[Partial aggregates]
SlowMap --> EVENPART_SLOW[Even partitioning]

EVENPART_SLOW --> TOOMUCHDATA
EVENPART_SLOW --> LARGERECORDS


EVENPART_SLOW   --> MissingSourcePredicates[Reading more data than needed]
MissingSourcePredicates --> PartitionPruning[Partition Pruning]
MissingSourcePredicates --> ColumnPruning[Column Pruning]
MissingSourcePredicates --> PredicatePushDown[Predicate Push Down]

EVENPART_SLOW   --> TooFewMapTasks[Not enough Read/Map Tasks]
EVENPART_SLOW   --> TooManyMapTasks[Too many Read/Map Tasks]
EVENPART_SLOW   --> SlowTransformations[Slow Transformations]
SlowMap   --> SkewedMapTasks[Skewed Map Tasks and uneven partitioning]
SkewedMapTasks --> RecordSkew[Record Skew]
SkewedMapTasks --> TaskSkew[Task skew]
TaskSkew --> READPARTITIONISSUES["Read partition issues"]

SlowReduce --> TooFewShuffleTasks[Not Enough Shuffle Tasks]
SlowReduce --> TooManyShuffleTasks[Too many shuffle tasks]
SlowReduce --> SkewedShuffleTasks[Skewed Shuffle Tasks]
SlowReduce --> SpillToDisk[Spill To Disk]
SkewedShuffleTasks --> SkewedJoin[Skewed Join]
SkewedShuffleTasks --> SkewedAggregation[Aggregation/Group By]


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

TOOMUCHDATA[Reading more data than needed]
TOOMUCHDATA --> FILTERNOTPUSHED[Filter not pushed down]
TOOMUCHDATA --> AGGNOTPUSHED[Aggregation not pushed down]
TOOMUCHDATA --> STORAGE_PARTITIONING[Bad storage partitioning]

SLOWWRITESTOSTORAGE[Slow writes to storage]
SLOWWRITESTOSTORAGE --> TOOMANYFILES[Slow writes because there are too many files]
SLOWWRITESTOSTORAGE --> SkewedWrite[Skewed Write: when to use Sort/Repartition/Coalesce before write]
SLOWWRITESTOSTORAGE --> S3COMMITTER[Slow writes on S3 depend on the committer]

click EVENPART_SLOW "../../details/even_partitioning_still_slow"
click UDFSLOWNESS "../../details/udfslow"

click PAGGS "../../details/partial_aggregates"

click FILTERNOTPUSHED "../../details/slow-partition_filter_pushdown"
click SLOWEXEC "../../details/slow-executor"
click SLOWSTAGE "../../details/slow-stage"
click SLOWWRITESTOSTORAGE "../../details/slow-writes"
click SkewedWrite "../../details/slow-skewed-write"
click TOOMANYFILES "../../details/slow-writes-too-many-files"
click S3COMMITTER "../../details/slow-writes-s3"

click TOOMANY "../../details/toomany_tasks"
click TOOFEW "../../details/toofew_tasks"
click NOTENOUGHEXEC "../../details/notenoughexecs"
click SHUFFLEPARTITIONISSUES "../../details/slow-reduce"
click READPARTITIONISSUES "../../details/read-partition-issue"

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
