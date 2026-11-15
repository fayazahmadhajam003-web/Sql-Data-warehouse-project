--Create DDL for the crm_cust_csv file to in the warehouse database(2) 
--provided that it would have same indentical and equal number of parameters as that of parent csv file

Create table bronze.crm_cust_info(
	cst_id INT ,
	cst_Key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_create_date DATE
)


--first check if there id any such table in warehouse then drop it 
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
--Ceate SQL DDL scripts for all CSV  files in the CRM Aand  ERP systems
CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
    cid   NVARCHAR(50),
    cntry NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
    cid   NVARCHAR(50),
    bdate DATE,
    gen   NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id          NVARCHAR(50),
    cat         NVARCHAR(50),
    subcat      NVARCHAR(50),
    maintenance NVARCHAR(50)
);

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);

--DEVELOP SQL LOAD SCRIPTS
--TRUNCATE --- delete all the rows from a table , resetting it to an empty state (make table empty first)(2.1)
truncate table bronze.crm_cust_info;
--BULK INSERT- > inserting files data from dounload files  into single database in one operation(2.2)

BULK INSERT bronze.crm_cust_info
--write the data address from where file is driven
FROM 'C:\Users\fayaz\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
Firstrow=2,  --frist row start from row 2 becaz 1 is headind/titles
fieldterminator=',',  --each value is searated by comma
tablock
);
----CALCULATE THE NUMBER OF COLUMNS
--select count(*) from bronze.crm_cust_info  as columns;

-- =============================================================================
-- LOADING CRM TABLES
-- =============================================================================
-- TRUNCATE: Delete all existing rows from crm_cust_info
TRUNCATE TABLE bronze.crm_cust_info;
-- BULK INSERT: Load customer data from CSV into bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\fayaz\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
-- VERIFY: Check total rows loaded
-- SELECT COUNT(*) AS total_rows FROM bronze.crm_cust_info;
-- TRUNCATE: Delete all existing rows from crm_prd_info
TRUNCATE TABLE bronze.crm_prd_info;
-- BULK INSERT: Load product data from CSV into bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\fayaz\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
-- VERIFY: Check total rows loaded
-- SELECT COUNT(*) AS total_rows FROM bronze.crm_prd_info;
-- TRUNCATE: Delete all existing rows from crm_sales_details
TRUNCATE TABLE bronze.crm_sales_details;
-- BULK INSERT: Load sales transactions from CSV into bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\fayaz\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
-- VERIFY: Check total rows loaded
-- SELECT COUNT(*) AS total_rows FROM bronze.crm_sales_details;
-- =============================================================================
-- LOADING ERP TABLES
-- =============================================================================
-- TRUNCATE: Delete all existing rows from erp_cust_az12
TRUNCATE TABLE bronze.erp_cust_az12;
-- BULK INSERT: Load ERP customer demographics from CSV into bronze.erp_cust_az12
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\fayaz\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
-- VERIFY: Check total rows loaded
-- SELECT COUNT(*) AS total_rows FROM bronze.erp_cust_az12;
-- TRUNCATE: Delete all existing rows from erp_loc_a101
TRUNCATE TABLE bronze.erp_loc_a101;
-- BULK INSERT: Load ERP customer locations from CSV into bronze.erp_loc_a101
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\fayaz\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
-- VERIFY: Check total rows loaded
-- SELECT COUNT(*) AS total_rows FROM bronze.erp_loc_a101;
-- TRUNCATE: Delete all existing rows from erp_px_cat_g1v2
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
-- BULK INSERT: Load ERP product categories from CSV into bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\fayaz\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
-- VERIFY: Check total rows loaded
-- SELECT COUNT(*) AS total_rows FROM bronze.erp_px_cat_g1v2;
