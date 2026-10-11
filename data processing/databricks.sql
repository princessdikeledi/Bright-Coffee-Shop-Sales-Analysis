--big code
use brightcoffee.shop; --is from the given database

SELECT*
  FROM brightcoffee.shop.bright_coffee_shop_sales_dataset;

  SELECT 
    transaction_date,
    DAYNAME(transaction_date) AS Day_name, --gives the name of the day. creates a new column.
    MONTHNAME(transaction_date) AS Month_name, --gives the name of the month. creates a new column.

    --sales metrics
     COUNT(transaction_id) AS number_of_sales, --counts all the rows. creates a new column.
     SUM(transaction_qty) AS units_sold, --gives the sum total of the column. creates a new column.
     COUNT(DISTINCT product_id) AS unique_products, --counts all the rows and removes duplicates. creates a new column.
     COUNT(store_id) AS number_of_stores, --count all the rows in the column. creates a new column.

     --total revenue
     SUM(CAST(transaction_qty * unit_price AS DOUBLE)) AS revenue, --gives the sum total of both the names columnsv and creates a new column.
    HOUR(TRY_CAST(transaction_time AS TIMESTAMP)) AS time_classification,
     --gives the time of the week. creates a new column.
  
     
 
    --classifying the day
    CASE 
        WHEN DAYNAME(transaction_date) IN ('Sat','Sun') THEN 'Weekend'
        WHEN DAYNAME(transaction_date) IN ('Mon','Tue','Wed','Thu','Fri') THEN 'Weekday'
    END AS day_classification,

    CASE
    WHEN HOUR(TRY_CAST(transaction_time AS TIMESTAMP)) BETWEEN 6 AND 11
        THEN 'Morning'

    WHEN HOUR(TRY_CAST(transaction_time AS TIMESTAMP)) BETWEEN 12 AND 16
        THEN 'Afternoon'

    WHEN HOUR(TRY_CAST(transaction_time AS TIMESTAMP)) BETWEEN 17 AND 21
        THEN 'Evening'

    WHEN HOUR(TRY_CAST(transaction_time AS TIMESTAMP)) BETWEEN 22 AND 23
        OR HOUR(TRY_CAST(transaction_time AS TIMESTAMP)) BETWEEN 0 AND 5
        THEN 'Night'

    ELSE 'Unknown'
END AS time_classification, 

    store_location,
    product_category,
    product_type,
    product_detail,
    transaction_time

FROM brightcoffee.shop.bright_coffee_shop_sales_dataset

GROUP BY 
    transaction_date,
    Day_name,
    month_name,
    store_location,
    product_category,
    product_type,
    product_detail,
    time_classification,
    day_classification,
    transaction_time,

    

    CASE 
        WHEN DAYNAME(transaction_date) IN ('Sat','Sun') THEN 'Weekend'
        WHEN DAYNAME(transaction_date) IN ('Mon','Tues','Wednes','Thurs','Friday') THEN 'Weekday'
    END ,

    CASE 
        WHEN transaction_time BETWEEN '06:00' AND '11:59' THEN 'Morning'
        WHEN transaction_time BETWEEN '12:00' AND '17:59'  THEN 'Afternoon'
        WHEN transaction_time BETWEEN '18:00' AND '20:59' THEN 'Evening'
    END ;

   
    
