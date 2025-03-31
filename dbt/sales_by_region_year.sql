{{ config(materialized='table') }}
SELECT
  Year,
  SUM(NA_Sales) AS na_sales,
  SUM(EU_Sales) AS eu_sales,
  SUM(JP_Sales) AS jp_sales,
  SUM(Other_Sales) AS other_sales
FROM
    `your_table`  /*change to your table name*/
WHERE
  Year IS NOT NULL
GROUP BY
  Year
ORDER BY
  Year
