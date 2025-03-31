{{ config(materialized='table') }}
SELECT
  Platform,
  Year,
  SUM(Global_Sales) AS total_sales
FROM
  `your_table`  /*change to your table name*/
WHERE
  Year IS NOT NULL
GROUP BY
  Platform, Year
ORDER BY
  Year, total_sales DESC
