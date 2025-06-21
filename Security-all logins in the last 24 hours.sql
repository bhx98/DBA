--all logins in the last 24 hours
SELECT [Login] = login_name
	,[Last Login Time] = login_time
	,[Host] = HOST_NAME
	,[Program] = PROGRAM_NAME
	,[Client Interface] =  client_interface_name
	,[Database] = DB_NAME(database_id)
FROM sys.dm_exec_sessions
WHERE [login_time] > DATEADD(HH,-4,getdate())--modify date as needed
ORDER BY [login_time] desc