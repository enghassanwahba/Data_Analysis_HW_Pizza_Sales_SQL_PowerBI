use Pizza_DB

select * from pizza_sales

GO
create or alter view dbo.VW_KPI_1_Total_Revenue as
--1)Total Revenue
select sum(total_price) [TotalRevenue]
from pizza_sales

GO
create or alter view dbo.VW_KPI_2_Average_Order_Value as
--2)Average Order Value
select sum(total_price)/
count(distinct order_id)  As [Average Order Value]
from pizza_sales

GO
create or alter view dbo.VW_KPI_3_Total_Pizza_sold as
--3)Total Pizza sold
select sum(quantity) [Total Pizza sold]
from pizza_sales

GO
create or alter view dbo.VW_KPI_4_Total_Orders as
--4)Total Orders
select count(distinct order_id)  As [Total Orders]
from pizza_sales

GO
create or alter view dbo.VW_KPI_5_Average_Pizza_per_Order as
--5)Average Pizza Per Order
select 
cast(
cast(sum(quantity) as decimal(10,2)) /
count(distinct order_id) as decimal(10,2)) As [Avg Pizza Per Order]
from pizza_sales

GO
create or alter view dbo.VW_KPI_6_Top_5_Total_Q_by_Pizza_Name as
--6)Top 5 Total Quantity by Pizza Name
select top 5
      pizza_name,
      sum(quantity) [Total Quantity]
from pizza_sales
group by pizza_name
order by [Total Quantity] Desc 

GO
create or alter view dbo.VW_KPI_7_Worest_5_Total_Q_by_Pizza_Name as

--7)Worest 5 Total Quantity by Pizza Name
select top 5
      pizza_name,
      sum(quantity) [Total Quantity]
from pizza_sales
group by pizza_name
order by [Total Quantity] 

GO
create or alter view dbo.VW_KPI_8_Top_5_Total_Orders_by_Pizza_Name as
--8)Top 5 Total Orders by Pizza Name
select top 5
      pizza_name,
      count(distinct order_id) [Total Orders]
from pizza_sales
group by pizza_name
order by [Total Orders] Desc 

GO
create or alter view dbo.VW_KPI_9_Worest_5_Total_Orders_by_Pizza_Name as
--9)worest 5 Total Orders by Pizza Name
select top 5
      pizza_name,
      count(distinct order_id) [Total Orders]
from pizza_sales
group by pizza_name
order by [Total Orders]

GO
create or alter view dbo.VW_KPI_10_Top_5_Total_Sales_by_Pizza_Name as
--10)Top 5 Total Sales by Pizza Name
select top 5
      pizza_name,
      sum(total_price) [Total Sales]
from pizza_sales
group by pizza_name
order by [Total Sales] Desc 

GO
create or alter view dbo.VW_KPI_11_Worest_5_Total_Sales_by_Pizza_Name as
--11)worest 5 Total Sales by Pizza Name
select top 5
      pizza_name,
      sum(total_price) [Total Sales]
from pizza_sales
group by pizza_name
order by [Total Sales] 

GO
create or alter view dbo.VW_KPI_12_Daily_Trend_of_Total_Orders as
--12)Daily Trand of Total Orders
select
     DATEPART(weekday,order_date) [Day num],
     datename(weekday,order_date) [Day name],
     count(distinct order_id) [Total Orders]
from pizza_sales
group by DATEPART(weekday,order_date),datename(weekday,order_date) 

GO
create or alter view dbo.VW_KPI_13_Monthly_Trend_of_Total_Orders as
--13)Monthly Trand of Total Orders
select
     DATEPART(MONTH,order_date) [MONTH num],
     datename(MONTH,order_date) [MONTH name],
     count(distinct order_id) [Total Orders]
from pizza_sales
group by DATEPART(MONTH,order_date),datename(MONTH,order_date)

GO
create or alter view dbo.VW_KPI_14_Percent_of_Sales_by_Pizza_CAT as
--14)Percent of Sales by Pizza Category
select
     pizza_category,
     round(sum(total_price)*100.0/(select sum(total_price)from pizza_sales),2) [PCT]
from pizza_sales
group by pizza_category


GO
create or alter view dbo.VW_KPI_15_Percent_of_Sales_by_Pizza_Size as
--15)Percent of Sales by Pizza Size
select
     pizza_size,
     round(sum(total_price)*100.0/(select sum(total_price)from pizza_sales),2) [PST]
from pizza_sales
group by pizza_size


GO
create or alter view dbo.VW_KPI_16_Total_Pizza_Sold_by_Pizza_CAT as
--16)Total Pizza Sold by Pizza Category
select
     pizza_category,
     sum(quantity) [Total Pizza Sold/Cat]
from pizza_sales
group by pizza_category


GO
create or alter view dbo.VW_KPI_17_Total_Pizza_Sold_by_Pizza_CAT as
--17)Total Pizza Sold by Pizza Size
select
     pizza_size,
     sum(quantity) [Total Pizza Sold/S]
from pizza_sales
group by pizza_size


GO



