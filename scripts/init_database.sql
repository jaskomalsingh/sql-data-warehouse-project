-- Script to create the 'DataWarehouse' database from scratch.
-- It checks if the 'DataWarehouse' database already exists, 
-- sets it to single-user mode, drops it, and recreates it.
-- After creating the database, it also creates three schemas: bronze, silver, and gold.


--Create Database 'Datawarehouse'

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;

GO

CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

  
