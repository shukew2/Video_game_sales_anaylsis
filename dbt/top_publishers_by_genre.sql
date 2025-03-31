{{ config(materialized='table') }}
SELECT
  Genre,
  Publisher,
  SUM(Global_Sales) AS total_sales
FROM
    `your_table`  /*change to your table name*/
WHERE
  Genre IS NOT NULL AND Publisher IS NOT NULL
GROUP BY
  Genre, Publisher
QUALIFY ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY SUM(Global_Sales) DESC) <= 5
