-- Overall Memory Usage
SELECT
    type,
    SUM(pages_kb) AS total_kb
FROM
    sys.dm_os_memory_clerks
GROUP BY
    type
ORDER BY
    total_kb DESC;

-- Buffer Pool Usage by Database
SELECT
    DB_NAME(database_id) AS database_name,
    COUNT(*) * 8 / 1024 AS buffer_pool_mb
FROM
    sys.dm_os_buffer_descriptors
GROUP BY
    database_id
ORDER BY
    buffer_pool_mb DESC;