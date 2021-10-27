```mermaid
graph TD
C[I have an exception or error]
BADAGGREGATE[Bad aggregation or window]

C --> EEOOM[Spark executor ran out of memory]
C --> EBOOM[Spark driver ran out of memory]
EEOOM --> KEYSKEW[Key Skew]
KEYSKEW --> BADAGGREGATE
ELARGERECORDS --> BADAGGREGATE
EEOOM --> ELARGERECORDS[Large records]
ELARGERECORDS --> ESPARSE[Sparse records]
ELARGERECORDS --> EPYUDFOOM[Python UDF OOM]
EEOOM --> EJSONREGEX[Json REGEX issues]
EEOOM --> ECONTAINEROOM[Container out of memory]
EEOOM --> ETOOBIGBROADCAST[Too big broadcast join]

EBOOM --> ETOOBIGBROADCAST[Too big broadcast join]
EBOOM --> ECONTAINEROOM[Container out of memory]
EBOOM --> COLLECT[Using collect]

click EEOOM "../../details/failure-executor-out-of-memory" "Executor OOM"
click ESPARSE "../../details/sparse-records" "Sparse records"
click COLLECT "../../details/collect" "Collect and friends"

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
