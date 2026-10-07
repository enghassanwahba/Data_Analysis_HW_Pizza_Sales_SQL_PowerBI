# 🍕 Pizza Sales End-to-End Analytics Project (SQL & Power BI)

## 📌 Project Overview
This project provides a comprehensive business intelligence solution for a corporate pizza store chain. By converting raw sales transactions into actionable analytics, this solution uncovers critical revenue drivers, consumer behavior trends, and menu performance metrics. 

The workflow is strictly optimized using a two-tier modern data pipeline:
1. **Data Engineering Layer:** Built inside **SQL Server (T-SQL)** using programmatic Views to clean, aggregate, and structuralize dimensional KPIs.
2. **Business Intelligence Layer:** Built inside **Power BI Desktop**, utilizing an integrated semantic model, dynamic DAX measures, and an executive-level interactive UI.

---

## 📊 Business Key Performance Indicators (KPIs)
Analysis of the 2015 fiscal data revealed the following store performance metrics:
* **Total Revenue:** \$817.86K
* **Average Order Value:** \$38.31
* **Total Pizzas Sold:** 49,574 units
* **Total Orders Placed:** 21,350 distinct orders
* **Average Pizzas Per Order:** 2.32
---
<img width="4059" height="2295" alt="Sql_Project pdf_page-0001" src="https://github.com/user-attachments/assets/4aefcae0-f765-40db-9034-8b50dd600d29" />

---

## 🧠 Business Insights & Analytical Findings

### 📅 1. Macro Temporal Sales Trends
* **Daily Peaks:** Order velocity is heavily weighted toward weekends. **Friday**, **Thursday**, and **Saturday** generate the highest transaction volumes, identifying the core demand windows.
* **Monthly Seasonality:** Peak operational demand aligns with the summer season, showing maximum total order volumes in **July, May, and August**.

### 🍕 2. Granular Product Segmentation (Category & Size)
* **Category Leader:** The **Classic Category** dominates market share, driving the highest overall sales volume and order frequencies (14.9K total pizzas sold).
* **Size Preference:** **Large (L) size pizzas** are the primary revenue generator, accounting for **45.89%** of global sales value, followed by Medium (M) at 30.49%.

### 🏆 3. Product Performance Ranks (Best vs. Worst Sellers)
* **Bestsellers:** 
  * **The Classic Deluxe Pizza** ranks #1 in sales volume/quantity (2.5K units) and total transaction counts (2.3K orders).
  * **The Thai Chicken Pizza** serves as the highest value contributor, yielding **Maximum Revenue** (\$43.43K).
* **Underperformers:** 
  * **The Brie Carre Pizza** fundamentally lags across all product metrics, registering the minimum quantity sold (490 units), lowest total revenue (\$11.6K), and lowest baseline consumer orders (480).
---
<img width="4059" height="2295" alt="Sql_Project pdf_page-0002" src="https://github.com/user-attachments/assets/c2674a80-9fba-44ee-83a1-4416590b85e8" />

---

## 🛠️ Tools, Frameworks & Tech Stack
* **Database Engine:** Microsoft SQL Server (T-SQL)
* **BI Platform:** Microsoft Power BI Desktop
* **UI/UX Customizations:** Fluent 2 Theme (JSON-based modern layout architecture)

---

## 📂 Project Repository Structure
This repository contains the completely decoupled programmatic SQL scripts alongside the Power BI report definition files:

```microtext
├── Executive_Pizza_Sales_Queries.sql     # Database setup & 17 production Views
├── Pizza_Sales_Report.pbix               # Main Power BI Desktop file
└── Report_Definitions/                   # Extracted BI report source metadata
    ├── definition/
    │   ├── report.json                   # Visual configurations
    │   └── pages/                        # Decoupled layout structures
    │       ├── e85ebf7dc4a4b2215f2d/     # Page 1: Sales Performance Dashboard
    │       └── 71e17e204faa166e1b39/     # Page 2: Best & Worst Sellers Grid
    └── StaticResources/                  # Custom icons, themes, and images
        └── SharedResources/BaseThemes/
            └── Fluent2-CY26SU09.json     # Corporate styling definitions
```


## 💾 Comprehensive Database Architecture (All 17 SQL Views)

The data access model utilizes **17 dedicated modular production views** written in T-SQL to isolate database compute loads from the reporting layer, ensuring continuous performance and data integrity.

### 🛠️ Group 1: Executive KPI Metrics Views

These views calculate the primary baseline metrics displayed in the executive scorecard of the pipeline.

```sql
-- 1) Total Revenue View
CREATE OR ALTER VIEW dbo.VW_KPI_1_Total_Revenue AS
SELECT SUM(total_price) [TotalRevenue]
FROM pizza_sales;
GO

-- 2) Average Order Value View
CREATE OR ALTER VIEW dbo.VW_KPI_2_Average_Order_Value AS
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS [Average Order Value]
FROM pizza_sales;
GO

-- 3) Total Pizza Sold View
CREATE OR ALTER VIEW dbo.VW_KPI_3_Total_Pizza_sold AS
SELECT SUM(quantity) [Total Pizza sold]
FROM pizza_sales;
GO

-- 4) Total Orders View
CREATE OR ALTER VIEW dbo.VW_KPI_4_Total_Orders AS
SELECT COUNT(DISTINCT order_id) AS [Total Orders]
FROM pizza_sales;
GO

-- 5) Average Pizza Per Order View
CREATE OR ALTER VIEW dbo.VW_KPI_5_Average_Pizza_per_Order AS
SELECT 
CAST(
CAST(SUM(quantity) AS DECIMAL(10,2)) /
COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS [Avg Pizza Per Order]
FROM pizza_sales;
GO
```

### 🏆 Group 2: Product Performance Ranking Views (Top & Worst Sellers)

These views handle the core product ranking mechanics across sales volume (quantity), operational order volume, and revenue generation.

```sql
-- 6) Top 5 Total Quantity by Pizza Name View
CREATE OR ALTER VIEW dbo.VW_KPI_6_Top_5_Total_Q_by_Pizza_Name AS
SELECT TOP 5
      pizza_name,
      SUM(quantity) [Total Quantity]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Quantity] DESC;
GO

-- 7) Worst 5 Total Quantity by Pizza Name View
CREATE OR ALTER VIEW dbo.VW_KPI_7_Worest_5_Total_Q_by_Pizza_Name AS
SELECT TOP 5
      pizza_name,
      SUM(quantity) [Total Quantity]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Quantity] ASC;
GO

-- 8) Top 5 Total Orders by Pizza Name View
CREATE OR ALTER VIEW dbo.VW_KPI_8_Top_5_Total_Orders_by_Pizza_Name AS
SELECT TOP 5
      pizza_name,
      COUNT(DISTINCT order_id) [Total Orders]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Orders] DESC;
GO

-- 9) Worst 5 Total Orders by Pizza Name View
CREATE OR ALTER VIEW dbo.VW_KPI_9_Worest_5_Total_Orders_by_Pizza_Name AS
SELECT TOP 5
      pizza_name,
      COUNT(DISTINCT order_id) [Total Orders]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Orders] ASC;
GO

-- 10) Top 5 Total Sales by Pizza Name View
CREATE OR ALTER VIEW dbo.VW_KPI_10_Top_5_Total_Sales_by_Pizza_Name AS
SELECT TOP 5
      pizza_name,
      SUM(total_price) [Total Sales]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Sales] DESC;
GO

-- 11) Worst 5 Total Sales by Pizza Name View
CREATE OR ALTER VIEW dbo.VW_KPI_11_Worest_5_Total_Sales_by_Pizza_Name AS
SELECT TOP 5
      pizza_name,
      SUM(total_price) [Total Sales]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Sales] ASC;
GO
```

### 📅 Group 3: Macro Temporal Trend Analysis Views

These views calculate transaction densities across specific daily and monthly time ranges to map organizational seasonality.

```sql
-- 12) Daily Trend of Total Orders View
CREATE OR ALTER VIEW dbo.VW_KPI_12_Daily_Trend_of_Total_Orders AS
SELECT
     DATEPART(WEEKDAY,order_date) [Day num],
     DATENAME(WEEKDAY,order_date) [Day name],
     COUNT(DISTINCT order_id) [Total Orders]
FROM pizza_sales
GROUP BY DATEPART(WEEKDAY,order_date), DATENAME(WEEKDAY,order_date);
GO

-- 13) Monthly Trend of Total Orders View
CREATE OR ALTER VIEW dbo.VW_KPI_13_Monthly_Trend_of_Total_Orders AS
SELECT
     DATEPART(MONTH,order_date) [MONTH num],
     DATENAME(MONTH,order_date) [MONTH name],
     COUNT(DISTINCT order_id) [Total Orders]
FROM pizza_sales
GROUP BY DATEPART(MONTH,order_date), DATENAME(MONTH,order_date);
GO
```

### 🍕 Group 4: Menu Structure & Attributes Share Views

These views handle category and structural size metrics to compute financial and volume percentages.

```sql
-- 14) Percentage of Sales by Pizza Category View
CREATE OR ALTER VIEW dbo.VW_KPI_14_Percent_of_Sales_by_Pizza_CAT AS
SELECT
     pizza_category,
     ROUND(SUM(total_price)*100.0/(SELECT SUM(total_price) FROM pizza_sales),2) [PCT]
FROM pizza_sales
GROUP BY pizza_category;
GO

-- 15) Percentage of Sales by Pizza Size View
CREATE OR ALTER VIEW dbo.VW_KPI_15_Percent_of_Sales_by_Pizza_Size AS
SELECT
     pizza_size,
     ROUND(SUM(total_price)*100.0/(SELECT SUM(total_price) FROM pizza_sales),2) [PST]
FROM pizza_sales
GROUP BY pizza_size;
GO

-- 16) Total Pizza Sold by Pizza Category View
CREATE OR ALTER VIEW dbo.VW_KPI_16_Total_Pizza_Sold_by_Pizza_CAT AS
SELECT
     pizza_category,
     SUM(quantity) [Total Pizza Sold/Cat]
FROM pizza_sales
GROUP BY pizza_category;
GO

-- 17) Total Pizza Sold by Pizza Size View
CREATE OR ALTER VIEW dbo.VW_KPI_17_Total_Pizza_Sold_by_Pizza_CAT AS
SELECT
     pizza_size,
     SUM(quantity) [Total Pizza Sold/S]
FROM pizza_sales
GROUP BY pizza_size;
GO
```

---

## 💾 1. Data Engineering Layer (SQL Server Views)
The data access model utilizes **17 dedicated modular production views** to isolate calculations from the reporting tier. This ensures data integrity and high processing speeds.

### Core KPI Infrastructure Views
```sql
-- View 1: Global Revenue Accumulation
CREATE OR ALTER VIEW dbo.VW_KPI_1_Total_Revenue AS
SELECT SUM(total_price) [TotalRevenue]
FROM pizza_sales;

-- View 2: Average Basket Value per Distinct Order
CREATE OR ALTER VIEW dbo.VW_KPI_2_Average_Order_Value AS
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS [Average Order Value]
FROM pizza_sales;

-- View 5: Volumetric Pizza Density Per Transaction
CREATE OR ALTER VIEW dbo.VW_KPI_5_Average_Pizza_per_Order AS
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS [Avg Pizza Per Order]
FROM pizza_sales;
```

### Advanced Ranking & Matrix Views
```sql
-- View 10: Top 5 Skus Ranked by Total Revenue Contribution
CREATE OR ALTER VIEW dbo.VW_KPI_10_Top_5_Total_Sales_by_Pizza_Name AS
SELECT TOP 5 pizza_name, SUM(total_price) [Total Sales]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Sales] DESC;

-- View 14: Percentage Revenue Share Contributed by Sku Category
CREATE OR ALTER VIEW dbo.VW_KPI_14_Percent_of_Sales_by_Pizza_CAT AS
SELECT
     pizza_category,
     ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales), 2) [PCT]
FROM pizza_sales
GROUP BY pizza_category;
```

---

## 📊 2. Business Intelligence Layer (Power BI Architectural Features)
* **Advanced Data Modeling:** Fully functional Star Schema implementation via `DataModel` orchestration.
* **Dynamic Slicers:** Integrated structural multi-filtering toggles allowing granular data parsing by `pizza_category` and target time horizons.
* **Theming Engine:** Governed under a modified Microsoft **Fluent 2 Responsive Theme**, ensuring consistent layout padding, font scales, and semantic coloring.
---

## 💡 Strategic Business Recommendations
1. **Labor Resource Optimization:** Synchronize high-density staffing allocations with predictable demand spikes on **Thursdays, Fridays, and Saturdays** to protect order-to-delivery KPIs.
2. **Seasonal Supply Chain Management:** Scale inventory safety stocks of key dough and cheese ingredients upwards ahead of the high-volume summer corridor (**May – August**).
3. **Product Lifecycle Interventions:**
   * **The Brie Carre Pizza** should undergo immediate pricing restructuring, or be phased out to mitigate specialized stock holding costs.
   * Leverage the brand equity of **The Thai Chicken Pizza** inside multi-buy promotional bundles to scale up average basket values.




