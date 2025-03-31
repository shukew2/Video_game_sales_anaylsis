# 🎮 Video Game Sales Analysis Pipeline

## 📌 Project Overview

This project explores the relationship between video game global sales and platforms across different years. With over 16,000 video game records that include region-wise sales (NA, EU, JP, Other), platform, genre, publisher, and release year, the objective is to analyze how platform popularity evolved and contributed to total sales over time.

Understanding these trends is beneficial for game developers, marketers, and business analysts — helping identify which platforms dominated sales in specific years, which genres were most profitable, and which publishers led the market. This project constructs a full cloud-based data pipeline that automates ingestion, transformation, and visualization of these trends.

---

## ☁️ Cloud Architecture & Tools Used

| Layer | Tool |
|------|------|
| Workflow Orchestration | **Kestra** |
| Storage | **Google Cloud Storage (GCS)** |
| Data Warehouse | **BigQuery** |
| Transformation | **dbt** |
| Visualization | **Looker Studio** |

---

## 🗂️ Data Ingestion & Workflow (Batch Pipeline)

The data pipeline follows a **batch ingestion model** orchestrated using **Kestra**, designed as an end-to-end workflow:

1. **Source**: Local Parquet files (e.g., `game_sales_2000.parquet`) are split by year.
2. **Kestra Workflow**:
   - Copies Parquet files into Kestra's working directory
   - Uploads them to GCS under path `video_game_sales/yearly/<filename>`
   - Loads the files from GCS into BigQuery's raw table: `video_game_sales_raw`
   - Creates the final table `video_game` (partitioned and clustered) if it does not exist
   - Inserts new records for the selected year

### ✅ Features

- Fully automated DAG: No manual step required
- Supports dynamic year-based ingestion
- Triggered manually or by cron (`year = current_year - 25`)

---

## 🏢 Data Warehouse (BigQuery Design)

The final table `video_game` in BigQuery is optimized for analysis:

- **Partitioned by**: `Year` (Integer Range: 1980–2025)
- **Clustered by**: `Platform`, `Genre`

This structure enables:
- Efficient year-based filtering
- Fast platform/genre-based aggregation
- Reduced query cost for dashboard queries

---

## ⚙️ Transformations (dbt)

A dbt project was created to organize transformations and create clean analytical tables.

### Models Created:

| Model | Description |
|-------|-------------|
| `sales_by_year` | Global sales by year |
| `sales_by_platform_year` | Platform-level yearly sales |
| `sales_by_genre` | Global sales by genre |
| `sales_by_region_year` | NA, EU, JP, Other sales by year |
| `top_publishers_by_genre` | Top publishers in each genre by sales |

These models enable flexible querying and form the basis of the dashboard visuals.

---

## 📊 Dashboard (Looker Studio)

An interactive dashboard was built in Looker Studio to present the analysis in a user-friendly way.

### Key Charts & Controls:

- **Line Chart**: Total Global Sales by Year
- **Pie Chart**: Platform Sales Distribution (filtered by year)
- **Stacked Bar Chart**: Yearly Sales per Platform
- **Date Range Control**: Select start and end year to filter all charts

### Sample View:

![Dashboard Preview](dashboard_screenshot.png)

> Users can filter by year range to observe changes in total sales and platform distribution over time.

---

## 🛠️ How to Run

1. Place Parquet files under `/tmp/split_by_year/`
2. Trigger Kestra flow (`video_game_sales_upload`) with desired year
3. Confirm data arrives in BigQuery table `video_game`
4. Run dbt transformations:
    ```bash
    dbt run
    ```
5. Open Looker Studio and connect to your BigQuery `video_game` models

---

## 📁 Folder Structure

