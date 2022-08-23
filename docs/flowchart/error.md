```mermaid
flowchart LR
Error[Error/Exception]


Error --> MemoryError[Memory Error]
Error --> ShuffleError[Shuffle Error]
Error --> StackOverflowError[Stack Overflow]
Error --> SqlAnalysisError[sql.AnalysisException]
Error --> OtherError[Others]

MemoryError --> DriverMemory[Driver]
MemoryError --> ExecutorMemory[Executor]

DriverMemory -->	DriverMemoryError[Spark driver ran out of memory]
DriverMemory -->	DriverMaxResultSize[MaxResultSize exceeded]
DriverMemory -->    TooBigBroadcastJoin[Too Big Broadcast Join]
DriverMemory -->    ContainerOOM[Container Out Of Memory]

ExecutorMemory -->	ExecutorMemoryError[Spark executor ran out of memory]
ExecutorMemory -->	ExecutorDiskError[Executor out of disk error]
ExecutorMemory -->  ContainerOOM
ExecutorMemory -->  LARGERECORDS[Too large record]

StackOverflowError --> TOOBIGDAG[Too Big DAG]

click Error "../../details/error-job"
click MemoryError "../../details/error-memory"

click DriverMemory "../../details/error-memory/#driver"
click DriverMemoryError "../../details/error-driver-out-of-memory"
click DriverMaxResultSize "../../details/error-driver-max-result-size"

click ExecutorMemory "../../details/error-memory/#executor"
click ExecutorMemoryError "../../details/error-executor-out-of-memory"
click ExecutorDiskError "../../details/error-executor-out-of-disk"

click ShuffleError "../../details/error-shuffle"
click SqlAnalysisError "../../details/error-sql-analysis"
click OtherError "../../details/error-other"

click ContainerOOM "../../details/container-oom"
click TooBigBroadcastJoin "../../details/big-broadcast-join" "Broadcast Joins"
click LARGERECORDS "../../details/failure-executor-large-record"
click TOOBIGDAG "../../details/toobigdag"



{%
  include-markdown "./shared.md"
  start="graph TD"
  end="OHNOES[Contact support]"
  comments=false
%}
```
