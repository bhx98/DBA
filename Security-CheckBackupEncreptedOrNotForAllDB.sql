SELECT 
     A.database_name
,    key_algorithm
,    encryptor_thumbprint
,    encryptor_type
,        is_encrypted
,    type
,    AB.physical_device_name
    FROM msdb.dbo.backupset A
INNER JOIN 
msdb.dbo.backupmediaset C ON A.media_set_id = C.media_set_id
INNER JOIN 
msdb.dbo.backupmediafamily AB on AB.media_set_id=A.media_set_id
ORDER BY A.backup_start_date  DESC