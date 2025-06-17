SELECT  
'alter index' as 'reindex_part1',
'[' + dbindexes.[name] + ']' as 'Index',
'on' as 'reindex_part2',
'[' + dbtables.[name] + ']' as 'Table',
CASE WHEN indexstats.avg_fragmentation_in_percent > 30
 THEN 'rebuild with (FILLFACTOR = 80)' ELSE 'reorganize' END as 'reindex_part3',
indexstats.avg_fragmentation_in_percent,
indexstats.page_count,
indexstats.alloc_unit_type_desc,
dbschemas.[name] as 'Schema'
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.database_id = DB_ID()
AND indexstats.avg_fragmentation_in_percent > 5
ORDER BY indexstats.avg_fragmentation_in_percent desc