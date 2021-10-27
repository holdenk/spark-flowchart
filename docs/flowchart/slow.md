```mermaid
graph TD

B[Slow]

B --> KEYSKEW

B --> TOOMUCHDATA[Reading more data than needed]
TOOMUCHDATA --> FILTERNOTPUSHED[Filter not pushed down]
TOOMUCHDATA --> AGGNOTPUSHED[Aggregation not pushed down]
TOOMUCHDATA --> PARTIONING

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
