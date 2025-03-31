{{ config(materialized='table') }}
SELECT
  Genre,
  SUM(Global_Sales) AS total_sales
FROM
  `your_table`  /*change to your table name*/
WHERE
  Genre IS NOT NULL
GROUP BY
  Genre
ORDER BY
  total_sales DESC
