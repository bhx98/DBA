select 
    all_tabs.[tables] as all_tables,
    no_pk.[tables] as no_pk_tables,
    cast(cast(100.0 * no_pk.[tables] / 
    all_tabs.[tables] as decimal(36, 1)) as varchar) + '%' as no_pk_percent
from
    (select count(*) as [tables]
    from sys.tables tab
        left outer join sys.indexes pk
            on tab.object_id = pk.object_id 
            and pk.is_primary_key = 1
    where pk.object_id is null) as no_pk
inner join 
    (select count(*) as [tables]
    from sys.tables) as all_tabs
on 1 = 1