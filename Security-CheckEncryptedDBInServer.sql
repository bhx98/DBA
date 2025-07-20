SELECT A.name AS 'Database Name'
,    B.name AS 'Cert Name'
,    C.encryptor_type AS 'Type'
,    CASE
                WHEN C.encryption_state = 3 THEN 'Encrypted'
                WHEN C.encryption_state = 2 THEN 'In Progress'
                ELSE 'Not Encrypted'
END AS State
,    C.encryption_state
,    C.percent_complete
,     C.key_algorithm
,     C.key_length
,     C.* FROM sys.dm_database_encryption_keys C
RIGHT JOIN sys.databases A ON A.database_id = C.database_id
LEFT JOIN sys.certificates B ON C.encryptor_thumbprint=B.thumbprint