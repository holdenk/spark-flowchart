```mermaid
flowchart LR

B[Slow]

B --> SLOWSTAGE[Slow stage]

SHUFFLE --> PARTITIONING[Partitioning]
SLOWSTAGE --> SLOWEXEC[Slow executor]
SLOWSTAGE --> UDFSLOWNESS[Slow UDF]
UDFSLOWNESS --> PAGGS[Partial aggregates]
PARTITIONING --> GOODPART_SLOW[Even partitioning]
PARTITIONING --> UNEVENPART[Uneven/Skewed partitioning]
UNEVENPART --> KEYSKEW

GOODPART_SLOW --> TOOMANY[Too many tasks]
GOODPART_SLOW --> TOOFEW[Not enough tasks]
GOODPART_SLOW --> NOTENOUGHEXEC[Not enough executors]

B --> TOOBIGDAG




SLOWSTAGE --> SHUFFLE[Exchange/Shuffle/Reducer]
SLOWSTAGE --> TRANSFORM[Read/Map]
TRANSFORM --> TOOMUCHDATA
TRANSFORM --> PARTITIONING
TRANSFORM --> LARGERECORDS

TOOMUCHDATA[Reading more data than needed]
TOOMUCHDATA --> FILTERNOTPUSHED[Filter not pushed down]
TOOMUCHDATA --> AGGNOTPUSHED[Aggregation not pushed down]
TOOMUCHDATA --> STORAGE_PARTITIONING[Bad storage partitioning]

click UNEVENPART "../../details/uneven_partitioning"
click GOODPART_SLOW "../../details/even_partitioning_still_slow"
click UDFSLOWNESS "../../details/udfslow"

click PAGGS "../../details/partial_aggregates"
click FILTERNOTPUSHED "../../details/filter_pushdown"
click SLOWEXEC "../../details/slow-executor"
click SLOWSTAGE "../../details/slowstage"

click TOOMANY "../../details/toomany_tasks"
click TOOFEW "../../details/toofew_tasks"
click NOTENOUGHEXEC "../../details/notenoughexecs"
click PARTITIONING "../../details/partitioning"

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}

```
