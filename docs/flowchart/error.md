```mermaid
flowchart LR
C[I have an exception or error]
BADAGGREGATE[Bad aggregation or window]

C --> FORCECOMPUTE[Exception occurs during write phase, but seems unrelated]
C --> EANALYSIS[Spark SQL Analysis Exception]


C --> EEOOM[Spark executor ran out of memory]
C --> EDOOM[Spark driver ran out of memory]
C --> FILEERROR[Invalid/Missing Files]
C --> ExecutorOutOfDiskError[Executor out of disk space errors]
ExecutorOutOfDiskError --> TOOBIGDAG
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

EANALYSIS --> ECORCOL[Correlated column is not allowed in predicate]

EDOOM --> ETOOBIGBROADCAST[Too big broadcast join]
EDOOM --> ECONTAINEROOM[Container out of memory]
EDOOM --> COLLECT[Using collect]
EDOOM --> EDRESULTSIZE[maxResultSize exceeded]
EDOOM --> TOOBIGDAG
ETOOBIGBROADCAST --> EFORCEDBROADCAST[Forced broadcast with disabled threshold]

C --> ENOTFOUND[Class or method not found]

click ExecutorOutOfDiskError "../../details/executor-out-of-disk"
click EEOOM "../../details/failure-executor-out-of-memory" "Executor OOM"
click ESPARSE "../../details/sparse-records" "Sparse records"
click COLLECT "../../details/collect" "Collect and friends"
click ETOOBIGBROADCAST "../../details/big-broadcast-join" "Broadcast Joins"
click FILEERROR "../../details/invalid-file" "Invalid or missing files"
click PARQUETBUTNOT "../../details/failed-to-read-non-parquet-file" "Failed to read non parquet file"
click EPYUDFOOM "../../details/pyudfoom" "Udf OOM"
click EFORCEDBROADCAST "../../details/broadcast-with-disable" "Forced broadcast with disabled"
click EDRESULTSIZE "../../details/driver-max-result-size" "bigger than spark.driver.maxResultSize"
click FORCECOMPUTE "../../details/forced-computations" "Force computations."
click ECORCOL "../../details/correlated-column-not-allowed" "Correlated column not allowed."
click EANALYSIS "../../details/analysis-exception"
click ENOTFOUND "../../details/class-or-method-not-found"

{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
