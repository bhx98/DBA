SELECT  A.name
,       A.type_desc
,       B.permission_name
,       B.state_desc
,       B.class_desc
FROM    sys.server_principals A
LEFT JOIN
       sys.server_permissions B
ON      B.grantee_principal_id = A.principal_id
ORDER BY A.name