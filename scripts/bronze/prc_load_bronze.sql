/* 
=====================================================================================================
Stored Procedure: Load Bronze Layer (Source - Bronze)
=====================================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CVS files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  -Uses the `BULK INSERT` comand to load data from csv Files to bronze tables.

Parameters:
  None.
 This stored procedure does not accept any parameters or return any values

Usage Example:
  EXEC broze.load_bronze;
*/
CREATE  OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
BEGIN TRY
	SET @batch_start_time = GETDATE();
	PRINT '================================================================='
	PRINT 'Loading Bronze Layer'
	PRINT '================================================================='
	
	PRINT '-----------------------------------------------------------------'
	PRINT 'Loading CRM Tables';
	PRINT '-----------------------------------------------------------------'	
	
	SET @start_time = GETDATE();
	PRINT '» Truncating Table: bronze.crm_cust_info';	
	TRUNCATE TABLE bronze.crm_cust_info
	
	PRINT '» Inserting Data Into Table: bronze.crm_cust_info';	
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\Vanio\Documents\Career\SQL\SQLBaraa\PraticeSkillsSQL\DataWarehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);  
	SET @end_time = GETDATE();
	PRINT '» Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';  
	PRINT '» ----------------------------------'; 

	--SELECT COUNT(*) FROM bronze.crm_cust_info

	SET @start_time = GETDATE();
	PRINT '» Truncating Table: bronze.crm_prd_info';	
	TRUNCATE TABLE bronze.crm_prd_info;
	
	PRINT '» Inserting Data Into Table: bronze.crm_prd_info';	
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\Vanio\Documents\Career\SQL\SQLBaraa\PraticeSkillsSQL\DataWarehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);  
	SET @end_time = GETDATE();
	PRINT '» Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '» ----------------------------------';

	--SELECT COUNT(*) FROM bronze.crm_prd_info
	SET @start_time = GETDATE();
	PRINT '» Truncating Table: bronze.crm
