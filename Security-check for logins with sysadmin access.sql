--check for logins with sysadmin access
SELECT [Login] = name
	,[Login Type] = type_desc
	,[Disabled] = is_disabled
FROM     master.sys.server_principals 
WHERE    IS_SRVROLEMEMBER ('sysadmin',name) = 1
ORDER BY [Login]