--DAC Sample Query For Troubleshooting

SELECT
req.session_id,
req.status,
req.total_elapsed_time
FROM sys.dm_exec_requests req
WHERE status = 'running'
AND req.total_elapsed_time > 1
GO

--  Locking Information
SELECT * FROM sys.dm_tran_locks
GO
--  Cache Status
SELECT * FROM sys.dm_os_memory_cache_counters
GO
--  Active Sessions
SELECT * FROM sys.dm_exec_sessions
GO
--  Requests Status
SELECT * FROM sys.dm_exec_requests
GO