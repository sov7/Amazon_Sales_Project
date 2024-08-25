-- 1. KPIs:

SELECT 
    COUNT(DISTINCT order_id)    AS num_of_orders,
    ROUND(SUM(amount))          AS sales
FROM
    sales_altered sa 

    
-- 2.1 Sales per Category:
    
WITH sales_per_category AS (
SELECT
    category,
    ROUND(SUM(amount))                              AS sales_per_category,
    ROUND(SUM(amount) * 100.0 /
    (SELECT SUM(amount) FROM sales_altered sa2), 2)  AS perc_of_total_sales
FROM 
    sales_altered sa 
GROUP BY 1
ORDER BY 2 DESC
)

-- 2.2 Quantity of items sold per Category:

, qty_per_category AS (
SELECT
    category,
    ROUND(SUM(qty))                             AS qty_per_category,
    ROUND(SUM(qty) * 100.0 /
    (SELECT SUM(qty) FROM sales_altered sa2), 2) AS perc_of_total_qty
FROM
    sales_altered sa 
GROUP BY 1
ORDER BY 2 DESC    
)

-- 2.3 Average price of item sold per Category:

SELECT 
    *,
    ROUND( sales_per_category / qty_per_category ) AS avg_price_per_category
FROM 
    sales_per_category spc
JOIN qty_per_category qpc USING(category)


-- 3. Total Sales time series chart
-- 3.1 By month:

SELECT 
    TO_CHAR(date, 'Month')  AS month,
    SUM(amount)             AS sales_per_month
FROM 
    sales_altered sa 
GROUP BY 1
ORDER BY 1
    
-- 3.2 By day of week:
    
SELECT 
    TO_CHAR(date, 'Dy') AS day_of_week,
    SUM(amount)         AS sales_per_day
FROM 
    sales_altered sa 
GROUP BY 1
ORDER BY 2 DESC

    
-- 4. Top 10 best selling size for each category
    
SELECT 
    RANK() OVER(ORDER BY total_in_millions DESC),
    category,
    SIZE,
    total_in_millions
FROM (
    SELECT 
        category,
        SIZE,
        ROUND(SUM(amount) / 1000000, 2)  AS total_in_millions
    FROM 
        sales_altered sa 
    GROUP BY 1, 2
    )
ORDER BY 1
LIMIT 10

    
-- 5. Total sales per Indian state

SELECT 
    ship_state  AS state,
    SUM(amount) AS total_sales_per_state
FROM 
    sales_altered sa 
GROUP BY 1
ORDER BY 2 DESC