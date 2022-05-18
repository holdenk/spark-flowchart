# Skewed Joins

If you are joining `dse.vhs_dnld_f`(all the downloadables viewed in playback) to `ds.dnld_incremental_d`(downloadables dimension) on `dnld_id`. Everytime, we launch a new title, one or more of the downlodables will be viewed a lot more than the others and hence will introduce an organic skew. 

Below sql can run into skew if one of more downloadables are popular as the rows per key not uniform.  

```
select 
  dd.stream_profile_type_desc 
  ,sum(vdf.dnld_duration_secs) as view_secs
from  
  dse.vhs_dnld_f vdf 
join
  dse.dnld_incremental_d dd on vdf.dnld_id = dd.dnld_id
where
  vdf.view_utc_date between 20220506 and 20220508
group by
  1
```

Above sql can be re-written as below, so we replicate each downloadable on the dimension 3 times by introducing a `dummy key` and generate a random key(salt) on the fact table. Now instead of just joining on `dnld_id`, we will join both on `dnld_id` and `dummy_key` and this will reduce the skew by 3x. 

```
select 
  dd.stream_profile_type_desc 
  ,sum(vdf.dnld_duration_secs) as view_secs
from  
  dse.vhs_dnld_f vdf 
join
  (select dnld_id, stream_profile_type_desc, EXPLODE_OUTER(ARRAY(0,1,2)) as dummy_key from dse.dnld_incremental_d)  dd 
  on vdf.dnld_id = dd.dnld_id and cast(vdf.dnld_id % 3 as int) = dd.dummy_key 
where
  vdf.view_utc_date between 20220506 and 20220508
group by
  1

```


[Dataset example](https://stash.corp.netflix.com/projects/SDE/repos/ocf/browse/recovery/src/main/scala/com/netflix/data/osf/recovery/backfill/ReadInputTables.scala#79-87)
[Dataframe example](https://stash.corp.netflix.com/projects/SDE/repos/oc-batch/browse/encoding/src/main/scala/com/netflix/data/oc/encoding/VhsDnldF.scala#116-118,130-132)