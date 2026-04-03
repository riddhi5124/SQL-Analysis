drop table if exists zepto;

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8, 2),
    discount_percent NUMERIC(5, 2), 
    available_quantity INTEGER DEFAULT 0,
    discounted_selling_price NUMERIC(8, 2),
    weight_in_gms INTEGER,
    is_out_of_stock BOOLEAN DEFAULT FALSE,
    quantity INTEGER
);


SELECT COUNT(*) FROM zepto;

SELECT*FROM zepto
LIMIT 10;

SELECT * FROM zepto
WHERE category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR discount_percent IS NULL
   OR available_quantity IS NULL
   OR discounted_selling_price IS NULL
   OR weight_in_gms IS NULL
   OR is_out_of_stock IS NULL
   OR quantity IS NULL;

SELECT DISTINCT category
FROM zepto
ORDER BY category;

SELECT is_out_of_stock, COUNT(sku_id)
FROM zepto
GROUP BY is_out_of_stock;

SELECT name, COUNT(sku_id) as "Number of SKUs"
From zepto
GROUP BY name
HAVING count(sku_id) >1
ORDER BY count(sku_id) DESC;

SELECT * FROM zepto
WHERE mrp=0 OR discounted_selling_price=0;

DELETE FROM zepto
WHERE mrp=0;

UPDATE zepto
SET mrp= mrp/100.0,
discounted_selling_price = discounted_selling_price/100.0;

SELECT mrp,discounted_selling_price FROM zepto

--TOP 10 BEST VALUE PRODUCTS BASED ON DISCOUNT PERCENTAGE.
SELECT DISTINCT name,mrp,discount_percent
FROM zepto
ORDER BY discount_percent DESC
LIMIT 10;

--WHAT ARE PRODUCTS WITH HIGH MRP BUT OUT OF STOCK
SELECT DISTINCT name,mrp
FROM zepto
WHERE is_out_of_stock= TRUE and mrp>300
ORDER BY mrp DESC;

--Calculate Estimated Revenue for each category
SELECT category,
SUM(discounted_selling_price* available_quantity) AS total_Revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;
--Identify the top 5 categories offering the highest average discount percentage
SELECT category, AVG(discount_Percent) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
--Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, discounted_selling_price, weight_in_gms,
ROUND (discounted_selling_price / weight_in_gms) AS price_per_gram
FROM zepto
WHERE weight_in_gms > 100
ORDER BY price_per_gram ASC;

--group the products into categories like LOW, MEDIUM,BULK
SELECT name, weight_in_gms,
CASE 
    WHEN weight_in_gms < 1000 THEN 'Low'
    WHEN weight_in_gms BETWEEN 1000 AND 5000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category
FROM zepto;

-- What is the Total Invenroty Weight Per Category
SELECT category,
SUM(weight_in_gms*available_quantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;