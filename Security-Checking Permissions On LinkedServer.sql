select svr.name
    , svr.data_source
    , svr.product
    , svr.is_linked
    , svr.is_remote_login_enabled
    , svr.is_rpc_out_enabled
    , svr.is_data_access_enabled
    , ll.local_principal_id
    , [Name] = case ll.local_principal_id when 0 then 'All unmapped users'
        else ISNULL(sp.name, '')
        end
    , [RemoteUser]= ISNULL(ll.remote_name, N'')
    , [Impersonate]= CAST(ll.uses_self_credential AS bit)
from sys.servers svr
join sys.linked_logins ll on
    svr.server_id=ll.server_id
LEFT OUTER JOIN sys.server_principals sp ON
    ll.local_principal_id = sp.principal_id;
GO
