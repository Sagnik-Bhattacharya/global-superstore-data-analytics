SELECT *
FROM superstore_cleaned
LIMIT 20
;

-- 1. Total sales, profit, shipping cost
SELECT
SUM(Sales) AS total_sale,
SUM(profit) AS total_profit,
SUM(shipping_cost) AS total_shipping_cost
FROM superstore_cleaned
;

-- 2. Unique orders & customers
SELECT
COUNT(DISTINCT order_id) AS unique_orders,
COUNT(DISTINCT customer_id) AS unique_customers
FROM superstore_cleaned;

-- 3. Average Order Value (AOV)
SELECT 
SUM(sales)/COUNT(DISTINCT order_id) AS average_order_value
FROM superstore_cleaned;

-- 4. Overall profit margin
SELECT 
(SUM(profit)/SUM(sales))*100 AS profit_margin_pct
FROM superstore_cleaned;

-- 5. Yearly sales & profit trend
SELECT
year,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY year
ORDER BY year
;

-- 6. Monthly sales & profit
SELECT
order_year,
order_month_name,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY order_month_name, order_year
ORDER BY order_month_name, order_year
;

-- 7. Best year by sales & profit
SELECT
order_year,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY order_year
ORDER BY 2,3 DESC
LIMIT 5
;

-- 8. Weekly sales pattern
SELECT
weeknum,
SUM(sales) AS weekly_sales
FROM superstore_cleaned
GROUP BY weeknum
ORDER BY weeknum DESC
;

-- 9. Sales by region
SELECT
region,
SUM(sales) AS total_sales
FROM superstore_cleaned
GROUP BY region
ORDER BY 2 DESC
;

-- 10. Profit by region
SELECT
region,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY region
ORDER BY 2 DESC
;

-- 11. Top countries by sales
SELECT
country,
SUM(sales) AS total_sales
FROM superstore_cleaned
GROUP BY country
ORDER BY 2 DESC
;

-- 12. Market profitability
SELECT
market,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY market
ORDER BY 2 DESC
;

-- 13. High sales, low profit regions
SELECT 
    Region,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Region
ORDER BY total_sales DESC, total_profit ASC
;

-- 14. Sales by category
SELECT
category,
SUM(sales) AS total_sales
FROM superstore_cleaned
GROUP BY category
;

-- 15. Profit by category
SELECT
category,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY category
;

-- 16. Most profitable sub-categories
SELECT
sub_category,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY sub_category
ORDER BY 2 DESC
LIMIT 5
;

-- 17. Loss-making sub-categories
SELECT
sub_category,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY sub_category
HAVING total_profit < 0
;

-- 18. Top 10 best-selling products
SELECT
product_name,
SUM(sales) AS total_sales
FROM superstore_cleaned
GROUP BY product_name
ORDER BY 2 DESC
LIMIT 10
;

-- 19. Top 10 loss-making products
SELECT
product_name,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY product_name
ORDER BY 2
LIMIT 10
;

-- 20. Sales by segment
SELECT
segment,
SUM(sales) AS total_sales
FROM superstore_cleaned
GROUP BY segment
ORDER BY 2 DESC
;

-- 21. Profit by segment
SELECT
segment,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY segment
ORDER BY 2 DESC
;

-- 22. Top 10 customers by sales
SELECT
customer_name,
SUM(sales) AS total_sales
FROM superstore_cleaned
GROUP BY customer_name
ORDER BY 2 DESC
LIMIT 10
;

-- 23. Top 10 customers by profit
SELECT
customer_name,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY customer_name
ORDER BY 2 DESC
LIMIT 10
;

-- 24. Repeat customers
SELECT
customer_name,
COUNT(customer_name) AS count_of_customers
FROM superstore_cleaned
GROUP BY customer_name
HAVING count_of_customers > 1
;

-- 25. Revenue from top customers
WITH ranked_customers AS (
    SELECT 
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM superstore_cleaned
    GROUP BY Customer_ID
)
SELECT 
    SUM(total_sales) / (SELECT SUM(Sales) FROM superstore_cleaned) * 100
    AS top_customer_revenue_pct
FROM ranked_customers
ORDER BY total_sales DESC
LIMIT 10
;

-- 26. Profit vs discount
SELECT
discount,
AVG(profit) AS average_profit
FROM superstore_cleaned
GROUP BY discount
ORDER BY discount DESC
;

-- 27. Discount threshold hurting profit
SELECT
discount,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY discount
ORDER BY discount DESC
;

-- 28. Discount impact by category
SELECT
category,
AVG(discount) AS average_discount_offered,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY category
ORDER BY 2 DESC
;

-- 29. High-discount order profitability

SELECT 
    CASE 
        WHEN Discount >= 0.3 THEN 'High Discount'
        ELSE 'Low Discount'
    END AS discount_group,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY discount_group
;

-- 30. Shipping mode usage
SELECT
ship_mode,
COUNT(*) AS count_of_shipping
FROM superstore_cleaned
GROUP BY ship_mode
;

-- 31. Most profitable shipping mode
SELECT 
ship_mode,
SUM(profit) AS total_profit
FROM superstore_cleaned
GROUP BY ship_mode
ORDER BY 2 DESC
;

-- 32. Avg shipping cost by mode
SELECT 
ship_mode,
AVG(shipping_cost) AS average_shipping_cost
FROM superstore_cleaned
GROUP BY ship_mode
ORDER BY 2 DESC
;

-- 33. Shipping speed vs margin
SELECT 
    Ship_Mode,
    (SUM(Profit) / SUM(Sales)) * 100 AS profit_margin
FROM superstore_cleaned
GROUP BY Ship_Mode
;


-- 34. Priority vs sales & profit
SELECT 
    Order_Priority,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Order_Priority
;

-- 35. Loss-making priorities
SELECT 
    Order_Priority,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Order_Priority
HAVING total_profit < 0
;

-- 36. High priority profitability
SELECT 
    Order_Priority,
    AVG(Profit) AS avg_profit_per_order
FROM superstore_cleaned
GROUP BY Order_Priority
;

-- 37. Best sales weeks
SELECT 
    weeknum,
    SUM(Sales) AS total_sales
FROM superstore_cleaned
GROUP BY weeknum
ORDER BY total_sales DESC
LIMIT 10
;

-- 38. Worst profit weeks
SELECT 
    weeknum,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY weeknum
ORDER BY total_profit ASC
LIMIT 10
;

-- 39. Seasonal trends
SELECT 
    MONTH(Order_Date) AS month,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY month
ORDER BY month
;

-- 40. Consistently loss-making products
SELECT 
    Product_Name,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Product_Name
HAVING total_profit < 0
;

-- 41. Regions needing discount optimization
SELECT 
    Region,
    AVG(Discount) AS avg_discount,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Region
HAVING total_profit < 0
;

-- 42. Growth segments
SELECT 
    Segment,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Segment
ORDER BY total_profit DESC
;

-- 43. Shipping cost optimization areas
SELECT 
    Region,
    AVG(Shipping_Cost) AS avg_shipping_cost,
    SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Region
;
