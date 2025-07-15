--Return login failed record from log file
EXEC master.sys.xp_readerrorlog 0, 1, N'login failed'


