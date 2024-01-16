Spark Error Flowchart: Note this uses mermaid.js which may take awhile to load.

```mermaid
graph TD
  A[Start here] --> B[Slow Running Job]
  C[I have an exception or error]
  A --> C
  click B "slow" "Slow"
  click C "error" "Error"
```
