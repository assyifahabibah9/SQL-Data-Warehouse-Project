/*
=============================================================
Membuat Database dan Schema
=============================================================
Tujuan Script:
    Script ini digunakan untuk membuat database baru bernama 'DataWarehouse' 
    setelah mengecek apakah database tersebut sudah ada atau belum. 
    Jika database sudah ada, database lama akan dihapus terlebih dahulu lalu dibuat ulang. 
    Selain itu, script ini juga akan menyiapkan tiga schema di dalam database: 
    'bronze', 'silver', dan 'gold'.
	
WARNING:
    Menjalankan script ini akan MENGHAPUS seluruh database 'DataWarehouse' jika sudah ada. 
    Semua data yang ada di dalam database akan terhapus secara permanen. 
    Harap berhati-hati dan pastikan Kamu sudah membuat backup data sebelum menjalankan script ini.
*/

USE master;
GO

-- Hapus dan buat ulang database 'DataWarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Buat database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Buat Schema (Layer Data)
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
