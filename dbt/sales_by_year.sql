-- models/sales_by_platform.sql

{{ config(materialized='table') }}

SELECT
  Year,
  SUM(Global_Sales) AS total_global_sales
FROM
    `your_table`  /*change to your table name*/
WHERE
  Year IS NOT NULL
GROUP BY
  Year
ORDER BY
  Year
