SELECT
    DB_NAME(database_id) AS database_name,
    file_id,
    io_stall_read_ms,
    io_stall_write_ms,
    num_of_reads,
    num_of_writes,
    size_on_disk_bytes
FROM
    sys.dm_io_virtual_file_stats(NULL, NULL)
ORDER BY
    (io_stall_read_ms + io_stall_write_ms) DESC;