# Data Warehouse and Analytics Project (Guided Project / Learning Showcase)

Repository ini berisi proyek praktikum dan implementasi end-to-end pembuatan **Data Warehouse & Analytics** yang saya pelajari dari sebuah course/tutorial terstruktur. 

Proyek ini bertujuan untuk memperdalam pemahaman praktis mengenai *best practices* industri dalam Data Engineering, pembuatan ETL Pipelines, Pemodelan Data (*Star Schema*), hingga *Quality Checking*.

---

## 📜 Credit & Acknowledgments

Proyek ini **bukanlah hasil perancangan independen dari nol**, melainkan hasil implementasi dan pembelajaran dari materi course/tutorial berikut:

- **Tutorial Source**: [YouTube - Building a Modern Data Warehouse Project](https://www.youtube.com/watch?v=9GVqKuTVANE)
- **Materi Pembelajaran**: Praktikum penuh membangun Data Warehouse mengadopsi *Medallion Architecture* (Bronze, Silver, Gold).

---

## 📚 Hasil Pembelajaran (Key Learnings)

Melalui proyek praktikum ini, saya mempelajari beberapa konsep inti dan keterampilan teknis sebagai berikut:

### 1. Konsep Dasar & Arsitektur Data Warehouse
- **Mengenal Arsitektur Data Warehouse & ETL**: Memahami alur pengolahan data mentah menjadi data bisnis yang terstruktur.
- **Medallion Architecture**: Mengimplementasikan pembagian data menjadi 3 layer:
  - **Bronze Layer**: Menyimpan data mentah (*raw data*) dari file CSV ke SQL Server.
  - **Silver Layer**: Pembersihan (*cleansing*), standardisasi, penanganan nilai *NULL*, serta penanganan *invalid data*.
  - **Gold Layer**: Pemodelan data analitis berbasis *Star Schema* (*Fact* dan *Dimension tables*).
- **Desain Arsitektur**: Mendokumentasikan alur data (*data flow*) dan arsitektur menggunakan diagram.

### 2. Pengelolaan Database & Proyek
- **Inisialisasi Database**: Membuat skema database (`bronze`, `silver`, `gold`) menggunakan DDL SQL (`init_database.sql`).
- **Aturan Penamaan (Naming Conventions)**: Menerapkan konvensi penamaan tabel dan kolom yang konsisten dan profesional.
- **Version Control**: Penggunaan Git & GitHub untuk melacak perubahan script SQL dan dokumentasi.

### 3. Pembuatan ETL Pipeline & Stored Procedures
- **Bronze Layer**: Mengimpor data CSV dari sistem sumber **CRM** dan **ERP** secara efisien.
- **Silver Layer**: Mengembangkan *Stored Procedures* untuk melakukan prapemrosesan data, penggabungan teks (*TRIM*), penanganan format tanggal, serta validasi matematika (misalnya `sales = quantity * price`).
- **Gold Layer**: Pemodelan *Star Schema* berbasis *View* (`dim_customers`, `dim_products`, `fact_sales`) menggunakan *Surrogate Keys* (`ROW_NUMBER()`).

### 4. Kualitas Data (Data Quality Checking)
- Menulis script pengujian kualitas data di layer Silver dan Gold (`quality_checks_silver.sql`, `quality_checks_gold.sql`) untuk memastikan keunikan kunci (*uniqueness*), integritas referensial, serta konsistensi logika antar tabel.

---

## 🏗️ Data Architecture

![Data Architecture](docs/data_architecture.png)

Proyek ini menggunakan **Medallion Architecture** (Bronze, Silver, Gold):
- **Bronze**: Data mentah yang diserap dari file CSV sistem ERP dan CRM.
- **Silver**: Data yang sudah dibersihkan, divalidasi, dan di-standardisasi.
- **Gold**: Data bisnis berstruktur *Star Schema* yang siap digunakan untuk kueri analitis dan pelaporan.

---

## 📂 Repository Structure

Struktur folder dalam repositori ini disusun sebagai berikut:

```text
SQL-Data-Warehouse-Project/
│
├── datasets/                            # File dataset mentah yang digunakan
│   ├── source_crm/                      # Data mentah dari sistem CRM
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   └── source_erp/                      # Data mentah dari sistem ERP
│       ├── cust_az12.csv
│       ├── loc_a101.csv
│       └── px_cat_g1v2.csv
│
├── docs/                                # Dokumentasi proyek, diagram, dan data catalog
│   ├── data_architecture.png            # Gambar diagram arsitektur data
│   ├── data_catalog.md                  # Katalog data dan penjelasan tiap kolom
│   ├── data_flow.pdf                    # Dokumentasi alur data
│   ├── data_integration.pdf             # Dokumentasi proses integrasi data
│   ├── data_layers.pdf                  # Dokumentasi pembagian layer (Bronze, Silver, Gold)
│   └── data_mart.pdf                    # Dokumentasi pemodelan data mart
│
├── scripts/                             # Script SQL untuk database dan ETL pipeline
│   ├── bronze/                          # Script DDL dan pemuatan data mentah
│   ├── silver/                          # Script pembersihan dan transformasi data
│   ├── gold/                            # Script pembuatan model analitis (Views)
│   └── init_database.sql                # Script untuk membuat database dan skema
│
├── tests/                               # Script validasi dan pengujian kualitas data
│   ├── quality_checks_gold.sql          # Pengujian integritas dan keunikan di layer Gold
│   └── quality_checks_silver.sql        # Pengujian kebersihan dan konsistensi di layer Silver
│
├── LICENSE                              # Lisensi proyek (MIT License)
└── README.md                            # Dokumentasi utama proyek

---

## 🛠️ Tools & Teknologi

* **Database Engine**: SQL Server Express
* **Management Tool**: SQL Server Management Studio (SSMS)
* **Version Control**: Git & GitHub
* **Diagramming**: Draw.io / PDF Export

---

## 🛡️ License

Proyek ini dilisensikan di bawah **MIT License**.

```

```
