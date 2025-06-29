--https://www.sqlshack.com/a-partial-backup-of-sql-databases/


CREATE DATABASE [PartialFG] ON PRIMARY
(
                                       NAME = N'PartialFG', 
                                       FILENAME = N'J:\Database\PartialFG.mdf'
), FILEGROUP [FG-A]
(
                                       NAME = N'PartialFG_A', 
                                       FILENAME = N'J:\Database\PartialFG_A.ndf'
), FILEGROUP [FG-B]
(
                                       NAME = N'PartialFG_B', 
                                       FILENAME = N'J:\Database\PartialFG_B.ndf'
), FILEGROUP [FG-C]
(
                                       NAME = N'PartialFG_C', 
                                       FILENAME = N'J:\Database\PartialFG_C.ndf'
) log ON
(
                                       NAME = N'PartialFG_log', 
                                       FILENAME = N'J:\Database\PartialFG_log.ldf'
);


ALTER DATABASE PartialFG SET RECOVERY SIMPLE

use PartialFG
GO
 --Create a table in filegroup PartialFG_A:
CREATE TABLE dbo.Customers
(ID           INT NOT NULL, 
 CustomerName NVARCHAR(50) NOT NULL,
)
ON [FG-A];
INSERT INTO Customers
VALUES
(1, 
 'Raj'
);
GO
 --Create a table in filegroup PartialFG_B:
CREATE TABLE dbo.Product
(ID          INT NOT NULL, 
 productname NVARCHAR(50) NOT NULL,
)
ON [FG-B];
INSERT INTO product
VALUES
(1, 
  'DB'
);
GO

 --Create a table in filegroup PartialFG_B:
CREATE TABLE dbo.archive
(ID          INT NOT NULL, 
 archivedata NVARCHAR(50) NOT NULL,
)
ON [FG-C];
INSERT INTO archive
VALUES
(1, 
 'archivedata'
);


 --Modify filegroup FG-C from read-write to read-only:
ALTER DATABASE PartialFG MODIFY FILEGROUP [FG-C] READONLY
GO

SELECT name, 
      physical_name, 
      state_desc, 
      is_read_only
FROM sys.database_files;

backup database PartialFG to disk='J:\Database\PartialFG.bak' with stats=10


INSERT INTO Customers
VALUES
(1, 
 'Raj'
);
UPDATE product
  SET 
      productname = 'database';


	  INSERT INTO Customers
VALUES
(1, 
 'Monu'
);
UPDATE product
  SET 
      productname = 'database SQL';


BACKUP DATABASE PartialFG READ_WRITE_FILEGROUPS
TO DISK = N'J:\Database\PartialFG_readwrite_diff.bak'
WITH DIFFERENTIAL
GO


RESTORE HEADERONLY FROM DISK = 'J:\Database\PartialFG.bak';
RESTORE HEADERONLY FROM DISK = 'J:\Database\PartialFG_readwrite.bak';
RESTORE HEADERONLY FROM DISK = 'J:\Database\PartialFG_readwrite_diff.bak';



--Restoring a full Partial backup
USE [master]
GO
     
RESTORE DATABASE [Restore-PartialFG]
FROM DISK =
    N'C:\Export\PartialFG.bak'
WITH NORECOVERY
GO
     
RESTORE DATABASE [Restore-PartialFG]
FROM DISK =
    N'C:\Export\PartialFG_readwrite.bak'
WITH RECOVERY
GO



USE [master]
GO
         
RESTORE DATABASE [Restore-PartialFG]
FROM DISK =
    N'C:\Export\PartialFG.bak'
WITH NORECOVERY
GO
RESTORE DATABASE [Restore-PartialFG]
FROM DISK =
    N'C:\Export\PartialFG_readwrite.bak'
WITH NORECOVERY
GO
         
RESTORE DATABASE [Restore-PartialFG]
FROM DISK =
    N'C:\Export\PartialFG_readwrite_diff.bak'
WITH RECOVERY
GO


