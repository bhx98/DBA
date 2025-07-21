--linked servers
EXEC sp_linkedservers
-- HADR Check
SELECT * FROM sys.dm_hadr_database_replica_states
--Cluster Check
SELECT * FROM sys.dm_hadr_cluster_members
-- Mirroring Check
SELECT A.name as [Database Name], * FROM sys.database_mirroring B
RIGHT JOIN sys.databases A on A.database_id = b.Database_ID
-- Replication check 
SELECT name, is_published, is_subscribed, is_merge_published, is_distributor
FROM sys.databases
-- External Data sources Check
SELECT * from sys.external_data_sources