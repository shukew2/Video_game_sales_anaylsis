## dbt Transformations (Data Modeling)

This project uses [dbt (Data Build Tool)](https://www.getdbt.com/) to manage SQL-based transformations in BigQuery.  
The goal is to build clean, modular, and query-optimized tables that support visualization and analytical use cases.

---
## Step-by-Step Process

### 1. Initialize a dbt Project

You can initialize the project by running:

<pre>
dbt init video_game_sales_dbt
</pre>

This will generate a new dbt project with basic files like `dbt_project.yml`, `models/`, and a sample model.

### 2. Set Up Your BigQuery Profile

In `~/.dbt/profiles.yml`, add the following configuration 

### 3. Create Models

Inside `models/`, create the following `.sql` files to transform raw data into aggregated or filtered tables:

- `sales_by_year.sql`
- `sales_by_platform_year.sql`
- `sales_by_genre.sql`
- `sales_by_region_year.sql`
- `top_publishers_by_genre.sql`

Each file is a `SELECT` query on the base table `video_game`, transforming it into useful analytics tables.
The sql files can be found [here]

### 4. Run Models

Build the transformed tables in BigQuery:
<pre>
dbt build
</pre>
