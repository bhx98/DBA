SELECT A.name AS Role, B.name AS Principal
FROM master.sys.server_role_members AB
INNER JOIN
master.sys.server_principals A 
ON A.principal_id = AB.role_principal_id AND A.type = 'R'
INNER JOIN
master.sys.server_principals B 
ON B.principal_id = AB.member_principal_id