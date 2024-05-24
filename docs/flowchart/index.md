Spark Error Flowchart: Note this uses mermaid.js which may take awhile to load.

```mermaid
graph TD
  A[Start here] --> B[Slow Running Job]
  C[I have an exception or error]
  D[Data Quality Issues]
  A --> C
  A --> D
  click B "slow" "Slow"
  click C "error" "Error"
  click D "dataquality" "Data Quality"
```
