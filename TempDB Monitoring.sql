SELECT
    SUM(user_object_reserved_page_count) * 8 as [User Object Space Utilization (KB)],
    SUM(internal_object_reserved_page_count) * 8 as [Internal Object Space Utilization (KB)],
    SUM(version_store_reserved_page_count) * 8 as [Version Store Space Utilization (KB)],
    SUM(unallocated_extent_page_count) * 8 as [Free Space (KB)],
    SUM(mixed_extent_page_count) * 8 as [Mixed Extent Space Utilization (KB)]
FROM
    tempdb.sys.dm_db_file_space_usage;