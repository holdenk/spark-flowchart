```mermaid
flowchart LR

B[Slow]

B --> SLOWSTAGE[Slow stage]

SLOWSTAGE --> PARTITIONING[Partitioning]
SLOWSTAGE --> SLOWEXEC[Slow executor]
SLOWSTAGE --> UDFSLOWNESS[Slow UDF]
UDFSLOWNESS --> PAGGS[Partial aggregates]
PARTITIONING --> GOODPART_SLOW[Even partitioning]
PARTITIONING --> BADPART[Uneven partitioning]
BADPART --> KEYSKEW

B --> TOOBIGDAG

B --> TOOMUCHDATA[Reading more data than needed]
TOOMUCHDATA --> FILTERNOTPUSHED[Filter not pushed down]
TOOMUCHDATA --> AGGNOTPUSHED[Aggregation not pushed down]
TOOMUCHDATA --> STORAGE_PARTITIONING[Bad storage partitioning]

click BADPART "../../details/bad_partitioning"
click GOODPART_SLOW "../../details/even_partitioning_still_slow"
click UDFSLOWNESS "../../details/udfslow"
click PAGGS "../../details/partial_aggregates"
click FILTERNOTPUSHED "../../details/filter_pushdown"
click SLOWEXEC "../../details/slow-executor"

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
