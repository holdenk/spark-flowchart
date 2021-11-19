```mermaid
graph TD
C[I have an exception or error]
BADAGGREGATE[Bad aggregation or window]

C --> EEOOM[Spark executor ran out of memory]
C --> EBOOM[Spark driver ran out of memory]
C --> FILEERROR[Invalid/Missing Files]
EEOOM --> KEYSKEW[Key Skew]
KEYSKEW --> BADAGGREGATE
ELARGERECORDS --> BADAGGREGATE
EEOOM --> ELARGERECORDS[Large records]
ELARGERECORDS --> ESPARSE[Sparse records]
ELARGERECORDS --> EPYUDFOOM[Python UDF OOM]
EEOOM --> EJSONREGEX[Json REGEX issues]
EEOOM --> ECONTAINEROOM[Container out of memory]
EEOOM --> ETOOBIGBROADCAST[Too big broadcast join]
FILEERROR --> PARQUETBUTNOT[Failed to read non-parquet file]

EBOOM --> ETOOBIGBROADCAST[Too big broadcast join]
EBOOM --> ECONTAINEROOM[Container out of memory]
EBOOM --> COLLECT[Using collect]
ETOOBIGBROADCAST --> EFORCEDBROADCAST[Forced broadcast with disabled threshold]

click EEOOM "../../details/failure-executor-out-of-memory" "Executor OOM"
click ESPARSE "../../details/sparse-records" "Sparse records"
click COLLECT "../../details/collect" "Collect and friends"
click ETOOBIGBROADCAST "../../details/big-broadcast-join" "Broadcast Joins"
click FILEERROR "../../details/invalid-file" "Invalid or missing files"
click PARQUETBUTNOT "../../details/failed-to-read-non-parquet-file" "Failed to read non parquet file"
click EPYUDFOOM "../../details/pyudfoom" "Udf OOM"
click EFORCEDBROADCAST "../../details/broadcast-with-disable" "Forced broadcast with disabled"


{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
