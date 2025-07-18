EXEC sp_MSforeachdb @command1 ='
      SELECT  ''?'' As DatabaseName 
      ,   DP1.name AS DatabaseRoleName
      ,   DP2.name AS DatabaseUserName
      FROM sys.database_role_members AS DRM
      RIGHT OUTER JOIN sys.database_principals AS DP1
          ON DRM.role_principal_id = DP1.principal_id  
      LEFT OUTER JOIN sys.database_principals AS DP2  
          ON DRM.member_principal_id = DP2.principal_id  
      WHERE 
          DP1.type = ''R'' AND 
          DP2.name IS NOT Null
      ORDER BY DP1.name;'