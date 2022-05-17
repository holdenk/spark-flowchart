# SQL Analysis Exception

Spark SQL `AnalysisException` covers a wide variety of potential issues, ranging from ambigious columns to more esotoric items like subquery issues. A good first step is making sure that your SQL is valid and your brackets are where you intend by putting your query through a SQL pretty-printer. After that hopefully the details of the `AnalysisException` error will guide you to one of the sub-nodes in the error graph.
