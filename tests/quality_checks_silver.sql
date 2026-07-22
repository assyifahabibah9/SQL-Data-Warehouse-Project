/*
===============================================================================
Pemeriksaan Kualitas Data (Quality Checks) - Layer Silver
===============================================================================
Tujuan Skrip:
    Skrip ini melakukan berbagai pemeriksaan kualitas untuk memastikan konsistensi,
    akurasi, dan standardisasi data pada layer 'Silver'. 

    Pemeriksaan meliputi:
    - Primary key yang bernilai NULL atau duplikat.
    - Spasi berlebih yang tidak diinginkan pada kolom teks.
    - Standardisasi dan konsistensi nilai data.
    - Rentang dan urutan tanggal yang tidak valid.
    - Konsistensi matematika/logika antar kolom yang saling berhubungan.

Catatan Penggunaan:
    - Jalankan pemeriksaan ini setelah proses memuat data (Data Loading) ke Layer Silver.
    - Investigasi dan selesaikan setiap ketidaksesuaian/masalah data yang ditemukan.
===============================================================================
*/

-- ====================================================================
-- 1. Pemeriksaan Tabel 'silver.crm_cust_info' (Informasi Pelanggan CRM)
-- ====================================================================
-- Memeriksa nilai NULL atau Duplikat pada Primary Key (cst_id)
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    cst_id,
    COUNT(*) AS jumlah_duplikat
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Memeriksa Spasi Berlebih di Awal atau Akhir Teks
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Memeriksa Standardisasi & Konsistensi Data (Status Pernikahan)
SELECT DISTINCT 
    cst_marital_status 
FROM silver.crm_cust_info;

-- ====================================================================
-- 2. Pemeriksaan Tabel 'silver.crm_prd_info' (Informasi Produk CRM)
-- ====================================================================
-- Memeriksa nilai NULL atau Duplikat pada Primary Key (prd_id)
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    prd_id,
    COUNT(*) AS jumlah_duplikat
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Memeriksa Spasi Berlebih pada Nama Produk
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Memeriksa Biaya/Harga Produk yang bernilai NULL atau Negatif
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Memeriksa Standardisasi & Konsistensi Data (Lini Produk)
SELECT DISTINCT 
    prd_line 
FROM silver.crm_prd_info;

-- Memeriksa Urutan Tanggal yang Tidak Valid (Tanggal Mulai > Tanggal Selesai)
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ====================================================================
-- 3. Pemeriksaan Tabel 'silver.crm_sales_details' (Detail Penjualan CRM)
-- ====================================================================
-- Memeriksa Tanggal Jatuh Tempo yang Tidak Valid pada Data Bronze
-- Ekspektasi Hasil: Tidak ada tanggal yang tidak valid
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Memeriksa Urutan Tanggal yang Tidak Logis (Tanggal Order > Tanggal Kirim/Jatuh Tempo)
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Memeriksa Konsistensi Rumus Matematika: Total Sales = Quantity * Price
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ====================================================================
-- 4. Pemeriksaan Tabel 'silver.erp_cust_az12' (Data Pelanggan ERP)
-- ====================================================================
-- Memeriksa Tanggal Lahir di Luar Rentang Wajar
-- Ekspektasi Hasil: Tanggal lahir harus di antara 1924-01-01 dan Hari Ini
SELECT DISTINCT 
    bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Memeriksa Standardisasi & Konsistensi Data (Jenis Kelamin)
SELECT DISTINCT 
    gen 
FROM silver.erp_cust_az12;

-- ====================================================================
-- 5. Pemeriksaan Tabel 'silver.erp_loc_a101' (Data Lokasi ERP)
-- ====================================================================
-- Memeriksa Standardisasi & Konsistensi Data (Nama Negara)
SELECT DISTINCT 
    cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ====================================================================
-- 6. Pemeriksaan Tabel 'silver.erp_px_cat_g1v2' (Kategori Produk ERP)
-- ====================================================================
-- Memeriksa Spasi Berlebih pada Kolom Teks
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Memeriksa Standardisasi & Konsistensi Data (Kolom Pemeliharaan/Maintenance)
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;
