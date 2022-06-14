```mermaid
flowchart LR

B[Slow]

B --> SLOWSTAGE[Slow stage]

SHUFFLE --> SHUFFLEPARTITIONISSUES[Partition issue at the shuffle phase]
SLOWSTAGE --> SLOWEXEC[Slow executor]
SLOWSTAGE --> UDFSLOWNESS[Slow UDF]
UDFSLOWNESS --> PAGGS[Partial aggregates]
SHUFFLEPARTITIONISSUES --> GOODPART_SLOW[Even partitioning]
SHUFFLEPARTITIONISSUES --> UNEVENPART[Uneven/Skewed partitioning]
UNEVENPART --> KEYSKEW

GOODPART_SLOW --> TOOMANY[Too many tasks]
GOODPART_SLOW --> TOOFEW[Not enough tasks]
GOODPART_SLOW --> NOTENOUGHEXEC[Not enough executors]

B --> TOOBIGDAG




SLOWSTAGE --> SHUFFLE[Exchange/Shuffle/Reducer]
SLOWSTAGE --> TRANSFORM[Read/Map]
SLOWSTAGE --> SLOWWRITESTOSTORAGE[Slow writes to storage]
TRANSFORM --> TOOMUCHDATA
TRANSFORM --> READPARTITIONISSUES[Partition issue on read]
TRANSFORM --> LARGERECORDS

TOOMUCHDATA[Reading more data than needed]
TOOMUCHDATA --> FILTERNOTPUSHED[Filter not pushed down]
TOOMUCHDATA --> AGGNOTPUSHED[Aggregation not pushed down]
TOOMUCHDATA --> STORAGE_PARTITIONING[Bad storage partitioning]

SLOWWRITESTOSTORAGE[Slow writes to storage]
SLOWWRITESTOSTORAGE --> TOOMANYFILES[Slow writes because there are too many files]
SLOWWRITESTOSTORAGE --> S3COMMITTER[Slow writes on S3 depend on the committer]

click UNEVENPART "../../details/uneven_partitioning"
click GOODPART_SLOW "../../details/even_partitioning_still_slow"
click UDFSLOWNESS "../../details/udfslow"

click PAGGS "../../details/partial_aggregates"
click FILTERNOTPUSHED "../../details/filter_pushdown"
click SLOWEXEC "../../details/slow-executor"
click SLOWSTAGE "../../details/slowstage"
click SLOWWRITESTOSTORAGE "../../details/slow-writes"
click TOOMANYFILES "../../details/slow-writes-too-many-files"
click S3COMMITTER "../../details/slow-writes-s3"

click TOOMANY "../../details/toomany_tasks"
click TOOFEW "../../details/toofew_tasks"
click NOTENOUGHEXEC "../../details/notenoughexecs"
click SHUFFLEPARTITIONISSUES "../../details/shuffle-partition-issue.md"
click READPARTITIONISSUES "../../details/read-partition-issue.md"

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}

```
