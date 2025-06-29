
DECLARE @MyFileName varchar(1000)

SELECT @MyFileName = (SELECT 'G:\Backup\Brokert\Brokert' + convert(varchar(500),GetDate(),112) + '.bak')

backup database Brokert to disk=@MyFileName
with init, CHECKSUM,COMPRESSION--,stats=20