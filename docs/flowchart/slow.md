```mermaid
flowchart LR

B[Slow]

B --> SLOWSTAGE[Slow stage]

SLOWSTAGE --> PARTIONING[Partioning]
SLOWSTAGE --> SLOWEXEC[Slow executor]
SLOWSTAGE --> UDFSLOWNESS[udfslowness]
UDFSLOWNESS --> PAGGS[Partial aggregates]
PARTIONING --> GOODPART_SLOW[Even partioning]
PARTIONING --> BADPART[Uneven partioning]
BADPART --> KEYSKEW


B --> TOOMUCHDATA[Reading more data than needed]
TOOMUCHDATA --> FILTERNOTPUSHED[Filter not pushed down]
TOOMUCHDATA --> AGGNOTPUSHED[Aggregation not pushed down]
TOOMUCHDATA --> STORAGE_PARTITIONING[Bad storage partioning]

B --> TOOBIGDAG

click BADPART "../../details/bad_partioning" "Slow stage with uneven partioning"
click GOODPART_SLOW "../../details/even_partioning_still_slow" "Slow stage with even partioning"
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
