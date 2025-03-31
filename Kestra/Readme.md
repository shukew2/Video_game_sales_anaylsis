### ⚙️ Kestra Pipeline (Data Ingestion & Loading)

This project uses [Kestra](https://kestra.io/) to orchestrate an automated data ingestion pipeline, handling the end-to-end process of loading video game sales data from local files to Google Cloud Storage (GCS) and BigQuery.

#### 📌 Main Workflow Steps

- **Upload to GCS**: Yearly-split local Parquet files are uploaded to a GCS bucket path structured by year.
- **Load into Raw Table**: Each yearly Parquet file is first loaded into a raw BigQuery table named `video_game_sales_raw`.
- **Create Final Table (if not exists)**: A partitioned (by `Year`) and clustered (by `Platform`, `Genre`) BigQuery table is created if not already existing.
- **Insert into Final Table**: Data is inserted from the raw table into the final optimized table, partitioned by year, using an SQL `INSERT` statement.

#### 🗓 Trigger & Scheduling

- A scheduled `cron` trigger is defined to run the workflow on the first day of each month.
- The `inputs.year` field allows for dynamic backfilling, enabling users to process historical years easily.

#### 🔧 Required Configuration (`kv()` variables)

- `GCP_CREDS`: GCP Service Account credentials
- `GCP_PROJECT_ID`: Google Cloud project ID
- `GCP_DATASET`: BigQuery dataset name
- `GCP_BUCKET_NAME`: Name of the GCS bucket
- `GCP_LOCATION`: GCP region (e.g., `us-central1`)

#### ✅ Why Kestra?

- Enables a **fully automated batch pipeline**, orchestrated through a DAG structure.
- Supports **custom year selection** and **scheduled execution** for continuous or backfill processing.
- Seamlessly integrates with downstream `dbt` transformations and the Looker Studio dashboard.

