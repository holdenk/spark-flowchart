Spark Error Flowchart: Note this uses mermaid.js which may take awhile to load.

```mermaid
flowchart LR

SlowJob[Slow Job]

SlowJob --> SlowStage[Slow Stage]

SlowStage --> SlowMap[Slow Read/Map]
SlowStage --> SlowReduce[Slow Shuffle/Reducer/Exchange]
SlowStage --> SLOWWRITESTOSTORAGE[Slow writes to storage]

SlowJob --> TOOBIGDAG[Too Big DAG]
SlowJob --> SlowCluster[Slow Cluster]

SlowReduce --> PAGGS[Partial aggregates]

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
click SlowCluster "../../details/slow-job-slow-cluster"
click TOOBIGDAG "../../details/toobigdag"

click TooFewShuffleTasks "../../details/slow-reduce/#not-enough-shuffle-tasks"
click TooManyShuffleTasks "../../details/slow-reduce/#too-many-shuffle-tasks"
click SkewedShuffleTasks "../../details/slow-reduce/#skewed-shuffle-tasks"
click SpillToDisk "../../details/slow-reduce/#spill-to-disk"

click SkewedJoin "../../details/slow-skewed-join"
click SkewedAggregation "../../details/slow-reduce/#skewed-shuffle-tasks"

SLOWWRITESTOSTORAGE[Slow writes to storage]
SLOWWRITESTOSTORAGE --> TOOMANYFILES[Slow writes because there are too many files]
SLOWWRITESTOSTORAGE --> SkewedWrite[Skewed Write: when to use Sort/Repartition/Coalesce before write]
SLOWWRITESTOSTORAGE --> S3COMMITTER[Slow writes on S3 depend on the committer]

click UDFSLOWNESS "../../details/udfslow"

click PAGGS "../../details/partial_aggregates"

click FILTERNOTPUSHED "../../details/slow-partition_filter_pushdown"
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
  end="OHNOES[Contact support]"
  comments=false
%}
```
