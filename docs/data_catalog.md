# Katalag Data untuk Gold Layer

## Overview

*Gold Layer* merupakan representasi data tingkat bisnis yang dirancang khusus untuk mendukung kebutuhan analisis dan pelaporan (*reporting*). Layer ini terdiri dari **tabel dimensi** (*dimension tables*) dan **tabel fakta** (*fact tables*) untuk metrik bisnis tertentu.

---

### 1. **gold.dim_customers**

* **Tujuan:** Menyimpan detail informasi pelanggan yang telah diperkaya dengan data demografi dan geografi.
* **Kolom:**

| Nama Kolom | Tipe Data | Deskripsi |
| --- | --- | --- |
| `customer_key` | INT | *Surrogate key* yang mengidentifikasi setiap rekaman pelanggan secara unik di dalam tabel dimensi. |
| `customer_id` | INT | Identifikasi numerik unik yang diberikan kepada setiap pelanggan. |
| `customer_number` | NVARCHAR(50) | Kode alfanumerik yang mewakili pelanggan, digunakan untuk pelacakan dan referensi. |
| `first_name` | NVARCHAR(50) | Nama depan pelanggan sesuai yang tercatat di dalam sistem. |
| `last_name` | NVARCHAR(50) | Nama belakang atau nama keluarga pelanggan. |
| `country` | NVARCHAR(50) | Negara tempat tinggal pelanggan (contoh: 'Australia'). |
| `marital_status` | NVARCHAR(50) | Status pernikahan pelanggan (contoh: 'Married', 'Single'). |
| `gender` | NVARCHAR(50) | Jenis kelamin pelanggan (contoh: 'Male', 'Female', 'n/a'). |
| `birthdate` | DATE | Tanggal lahir pelanggan dengan format YYYY-MM-DD (contoh: 1971-10-06). |
| `create_date` | DATE | Tanggal saat rekaman data pelanggan pertama kali dibuat di dalam sistem. |

---

### 2. **gold.dim_products**

* **Tujuan:** Menyediakan informasi mengenai produk beserta atribut-atributnya.
* **Kolom:**

| Nama Kolom | Tipe Data | Deskripsi |
| --- | --- | --- |
| `product_key` | INT | *Surrogate key* yang mengidentifikasi setiap rekaman produk secara unik di dalam tabel dimensi produk. |
| `product_id` | INT | Identifikasi unik yang diberikan pada produk untuk pelacakan dan referensi internal. |
| `product_number` | NVARCHAR(50) | Kode alfanumerik terstruktur yang mewakili produk, sering digunakan untuk kategorisasi atau inventaris. |
| `product_name` | NVARCHAR(50) | Nama deskriptif produk, mencakup detail penting seperti tipe, warna, dan ukuran. |
| `category_id` | NVARCHAR(50) | Identifikasi unik untuk kategori produk yang terhubung ke klasifikasi tingkat atas. |
| `category` | NVARCHAR(50) | Klasifikasi produk secara umum (contoh: Bikes, Components) untuk mengelompokkan item terkait. |
| `subcategory` | NVARCHAR(50) | Klasifikasi produk yang lebih detail di dalam suatu kategori, seperti tipe produk. |
| `maintenance_required` | NVARCHAR(50) | Menunjukkan apakah produk memerlukan pemeliharaan/perawatan (contoh: 'Yes', 'No'). |
| `cost` | INT | Biaya atau harga dasar produk dalam satuan mata uang. |
| `product_line` | NVARCHAR(50) | Lini produk atau seri spesifik tempat produk tersebut tergolong (contoh: Road, Mountain). |
| `start_date` | DATE | Tanggal saat produk mulai tersedia untuk dijual atau digunakan. |

---

### 3. **gold.fact_sales**

* **Tujuan:** Menyimpan data transaksi penjualan untuk kebutuhan analisis.
* **Kolom:**

| Nama Kolom | Tipe Data | Deskripsi |
| --- | --- | --- |
| `order_number` | NVARCHAR(50) | Identifikasi alfanumerik unik untuk setiap pesanan penjualan (contoh: 'SO54496'). |
| `product_key` | INT | *Surrogate key* yang menghubungkan pesanan ke tabel dimensi produk. |
| `customer_key` | INT | *Surrogate key* yang menghubungkan pesanan ke tabel dimensi pelanggan. |
| `order_date` | DATE | Tanggal saat pesanan dibuat/ditempatkan oleh pelanggan. |
| `shipping_date` | DATE | Tanggal saat pesanan dikirimkan kepada pelanggan. |
| `due_date` | DATE | Tanggal jatuh tempo pembayaran pesanan. |
| `sales_amount` | INT | Total nilai moneter penjualan untuk item tersebut dalam satuan mata uang utuh (contoh: 25). |
| `quantity` | INT | Jumlah unit produk yang dipesan untuk item tersebut (contoh: 1). |
| `price` | INT | Harga per unit produk untuk item tersebut dalam satuan mata uang utuh (contoh: 25). |
