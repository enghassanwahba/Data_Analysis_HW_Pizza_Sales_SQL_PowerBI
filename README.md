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




