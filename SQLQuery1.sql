select * from pizza_sales

select sum(total_price) as Total_Rvenue from pizza_sales

select sum(total_price) / count(distinct order_id) as Avg_Order_Val from pizza_sales

select sum(quantity) as Total_Pizza_Sold from pizza_sales

select count(distinct order_id) as Total_order from pizza_sales

select cast(cast(sum(quantity) as decimal(10,2))/ 
cast(count(distinct order_id) as decimal(10,2)) as  decimal(10,2)) as Avg_Pizza_Order from pizza_sales  

--DAILY TREND--
select DATENAME(DW, order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(DW, order_date)

--HOURLY TREND--

select DATEPART(HOUR, order_time) AS order_hours , count(distinct order_id) as Total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

-- % of sales by pizza category--

select pizza_category,sum(total_price) as total_sales,  sum(total_price) * 100/
(select sum(total_price) from pizza_sales where month(order_date)=1 ) as pct
from pizza_sales
where month(order_date)=1   --for particular month--
group by pizza_category

--% of sales by pizza size--

select pizza_size,cast(sum(total_price) as decimal(10,2)) as total_sales, cast( sum(total_price) * 100/
(select sum(total_price) from pizza_sales where datepart(QUARTER, order_date) = 1) as decimal (10,2)) as pct
from pizza_sales 
where datepart(QUARTER, order_date) = 1
group by pizza_size
order by pct desc


--total pizza sold--

select pizza_category, sum(quantity) as Total_pizza_sold 
from pizza_sales
group by pizza_category

--top 5 best seller--

select top 5 pizza_name, sum(quantity) as Total_pizza_sold 
from pizza_sales
group by pizza_name
order by sum(quantity) desc

-- bottom 5

select top 5 pizza_name, sum(quantity) as Total_pizza_sold 
from pizza_sales
group by pizza_name
order by sum(quantity) asc


