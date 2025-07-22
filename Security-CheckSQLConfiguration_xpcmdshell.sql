Select name
,    case
    when value_in_use = 0 then 'DISABLED'
    else 'ENABLED'
    end as State
,    description 
from sys.configurations
where name in ('xp_cmdshell')