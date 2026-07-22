/*
===============================================================================
Pemeriksaan Kualitas Data 
===============================================================================
Tujuan Skrip:
    Skrip ini melakukan pemeriksaan kualitas untuk memvalidasi integritas, 
    konsistensi, dan akurasi data pada Gold Layer. 

    Pemeriksaan ini memastikan:
    - Keunikan surrogate key pada tabel-tabel dimensi.
    - Integritas referensial antara tabel fakta dan tabel dimensi.
    - Validasi hubungan/konektivitas dalam model data untuk kebutuhan analitik.

Catatan Penggunaan:
    - Selidiki dan selesaikan setiap ketidaksesuaian/diskrepansi data yang 
      ditemukan selama proses pemeriksaan.
===============================================================================
*/

-- ====================================================================
-- 1. Pemeriksaan Tabel 'gold.dim_customers'
-- ====================================================================
-- Memeriksa Keunikan Customer Key pada gold.dim_customers
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- 2. Pemeriksaan Tabel 'gold.dim_products'
-- ====================================================================
-- Memeriksa Keunikan Product Key pada gold.dim_products
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- 3. Pemeriksaan Tabel 'gold.fact_sales'
-- ====================================================================
-- Memeriksa konektivitas model data antara Tabel Fakta dan Tabel Dimensi
-- Ekspektasi Hasil: Tidak ada data yang muncul (0 baris)
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL;
