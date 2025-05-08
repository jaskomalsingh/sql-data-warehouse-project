/*
this file is a stored procedure that loads data into the bronze schema from external csv files
it first truncates the table and then does a bulk insert

usage example: EXEC bronze.load_bronze
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	
	BEGIN TRY
	SET @batch_start_time = GETDATE();
		PRINT'====================================';
		PRINT 'loading bronze layer';
		PRINT'====================================';

		PRINT'====================================';
		PRINT 'loading CRM tables';
		PRINT'====================================';

		SET @start_time = GETDATE();
		PRINT ' >> Truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\jas\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '-------------------------------'

		SET @start_time = GETDATE();

		PRINT '>>Truncating table: bronze.crm_prd_info';

		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>>Inserting data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\jas\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------'

		SET @start_time = GETDATE();
		PRINT '>>Truncating table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT  '>>Inserting data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\jas\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------'

		PRINT'====================================';
		PRINT 'loading ERP tables';
		PRINT'====================================';

		SET @start_time = GETDATE();
		PRINT '>>Truncating table:bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT '>>Inserting data into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\jas\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW =2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------'

		SET @start_time = GETDATE();
		PRINT'>>Truncating table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101
		PRINT '>>Inserting data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\jas\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW =2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------'

		SET @start_time = GETDATE();
		PRINT '>>Truncating table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT '>>Inserting data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\jas\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------'
		SET @batch_end_time = GETDATE();
		PRINT '-------------------------------'
		PRINT '>> Load duration of entire batch: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------'
		END TRY
	BEGIN CATCH
		PRINT '====================='
		PRINT 'ERROR OCCURED DUIRNG LOADING BRONZE LAYER'
		PRINT 'error message' + ERROR_MESSAGE();
		PRINT 'error message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'error message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '====================='
	END CATCH 
END
