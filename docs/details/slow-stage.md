# Identify the slow stage


Steps: 

1. Navigate to Spark UI using spark history URL(found in genie stderr)
2. Click on `Stages` and sort the stages(click on `Duration`) in descending order to find the longest running stage.

 ![IdentifySlowStage](../imgs/identify-slow-stage.png)




### Now let's figure out if the slow stage is a `Map` or `Reduce/Shuffle`


Once you identify the slow stage, check the fields "Input", "Output", "Shuffle Read", "Shuffle Write" of the slow stage and use below grid to identify the stage type and the corresponding ETL action.

```
 -----------------------------------------------------------------------------------
| Input | Output | Shuffle Read | Shuffle Write |  MR Stage  |  ETL Action          |
|------------------------------------------------------------|----------------------|
|   X   |        |              |       X       |    Map     |     Read             |
|------------------------------------------------------------|----------------------|
|   X   |    X   |              |               |    Map     |   Read/Write         |
|------------------------------------------------------------|----------------------|
|   X   |        |              |               |    Map     | Sort Estimate        |
|------------------------------------------------------------|----------------------|
|       |        |      X       |               |    Map     | Sort Estimate        |
|------------------------------------------------------------|----------------------|
|       |        |      X       |       X       |   Reduce   | Join/Agg/Repartition |
|------------------------------------------------------------|----------------------|
|       |    X   |      X       |               |   Reduce   |     Write            |
 ------------------------------------------------------------|----------------------
    

```


go to [Map](../slow-map) if the slow stage is from a Map operation.
go to [Reduce](../slow-reduce) if the slow stage is from a Reduce/Shuffle operation.



