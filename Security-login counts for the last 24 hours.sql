--login counts for the last 24 hours
SELECT [Login] = login_name
	,[Last Login Time] = MAX(login_time)
	,[Number Of Logins] = COUNT(*)
FROM sys.dm_exec_sessions
WHERE [login_time] > DATEADD(HH,-4,getdate())--modify date as needed
GROUP BY [login_name]
ORDER BY [Login] desc