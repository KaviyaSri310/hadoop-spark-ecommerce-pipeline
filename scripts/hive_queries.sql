-- ============================================
-- ECOMMERCE DATA ANALYSIS USING HIVE
-- Project Output Queries
-- ============================================

USE ecommerce;

-- ============================================
-- 1. Total Revenue Generated
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/total_revenue'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT SUM(payment_value) AS total_revenue
FROM sales;



-- ============================================
-- 2. Total Number of Orders
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/total_orders'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT COUNT(*) AS total_orders
FROM sales;



-- ============================================
-- 3. Average Order Value
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/average_order_value'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT AVG(payment_value) AS avg_order_value
FROM sales;



-- ============================================
-- 4. Top 10 Highest Paying Customers
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/top_customers'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT customer_unique_id,
       SUM(payment_value) AS total_spent
FROM sales
GROUP BY customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;



-- ============================================
-- 5. Minimum and Maximum Payment
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/min_max_payment'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT MIN(payment_value) AS min_payment,
       MAX(payment_value) AS max_payment
FROM sales;



-- ============================================
-- 6. Customers with More Than 5 Orders
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/frequent_customers'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT customer_unique_id,
       COUNT(order_id) AS order_count
FROM sales
GROUP BY customer_unique_id
HAVING COUNT(order_id) > 5;



-- ============================================
-- 7. Revenue Distribution by Payment Range
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/payment_range_distribution'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT
CASE
    WHEN payment_value < 50 THEN 'Low'
    WHEN payment_value BETWEEN 50 AND 200 THEN 'Medium'
    ELSE 'High'
END AS payment_category,
COUNT(*) AS number_of_orders,
SUM(payment_value) AS total_revenue
FROM sales
GROUP BY
CASE
    WHEN payment_value < 50 THEN 'Low'
    WHEN payment_value BETWEEN 50 AND 200 THEN 'Medium'
    ELSE 'High'
END;



-- ============================================
-- 8. Top 5 Orders by Payment Value
-- ============================================
INSERT OVERWRITE LOCAL DIRECTORY '/home/kaviya/hive_outputs/top_orders'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT order_id,
       customer_unique_id,
       payment_value
FROM sales
ORDER BY payment_value DESC
LIMIT 5;



-- ============================================
-- END OF ANALYSIS
-- ============================================