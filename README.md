
## Project Overview
This project simulates a real-world **Data Analyst workflow** at a Quick-Commerce startup like Zepto. It involves taking raw, "messy" scraped inventory data and transforming it into actionable business insights using SQL.

### Key Objectives:
* **Schema Design:** Setting up a structured database for e-commerce SKUs.
* **Data Cleaning:** Handling unit conversions (Paise to Rupees) and filtering invalid entries.
* **Exploratory Data Analysis (EDA):** Identifying product gaps and stock inconsistencies.
* **Business Insights:** Analyzing revenue potential, category performance, and pricing strategies.

---

##  Dataset Overview
The dataset was sourced from Kaggle (originally scraped from Zepto). It represents a real-world product catalog where items often appear multiple times due to different sizes, weights, or discounts.

| Column | Description |
| :--- | :--- |
| **sku_id** | Unique identifier (Synthetic Primary Key) |
| **name** | Product name as shown on the app |
| **category** | Product segment (Fruits, Snacks, Beverages, etc.) |
| **mrp** | Maximum Retail Price (Converted to ₹) |
| **discountPercent** | Percentage discount applied |
| **availableQuantity** | Current units in stock |
| **outOfStock** | Boolean flag indicating availability |
| **weightInGms** | Product weight in grams |

---

##  Project Workflow

###  Database & Table Creation
We define the structure with strict data types to ensure data integrity.

```sql
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

```
---
###Data Import
Loaded CSV using pgAdmin's import feature.
Faced encoding issues (UTF-8 error), which were fixed by saving the CSV file using CSV UTF-8 format.

## Data and Preprocessing

###Data Exploration
Counted the total number of records in the dataset
Viewed a sample of the dataset to understand structure and content
Checked for null values across all columns
Identified distinct product categories available in the dataset
Compared in-stock vs out-of-stock product counts
Detected products present multiple times, representing different SKUs

###Data Cleaning
Identified and removed rows where MRP or discounted selling price was zero

Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability

### Business Insights
1)Found top 10 best-value products based on discount percentage

2)Identified high-MRP products that are currently out of stock

3)Estimated potential revenue for each product category

4)Ranked top 5 categories offering highest average discounts

5)Calculated price per gram to identify value-for-money products

6)Grouped products based on weight into Low, Medium, and Bulk categories

7)Measured total inventory weight per product category

---
