SELECT OBJECT_SCHEMA_NAME( object_id ) as SchemaName, name AS TableName
FROM sys.tables
WHERE OBJECTPROPERTY(object_id,'tablehasprimaryKey') = 0 
ORDER BY SchemaName, TableName ;