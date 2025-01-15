create database store;
select * from sample;
select max(a.sales) ,a.region,a.subcategory from
(select region,sum(sales) ,SubCategory from sample) as a
group by  region;

# q1 What are the total sales for each category?
SELECT Category,  round(SUM(Sales),2) AS TotalSales
FROM sample
GROUP BY Category;
#Q 2 What is the total profit for each sub-category?
SELECT SubCategory, SUM(Profit) AS TotalProfit
FROM sample
GROUP BY SubCategory;
#Q3 Which city has the highest average sales?

SELECT City, AVG(Sales) AS AverageSales
FROM sample
GROUP BY City
ORDER BY AverageSales DESC
LIMIT 1;

#q4 What are the top 5 customers with the highest total sales?

SELECT Customers, SUM(Sales) AS TotalSales
FROM sample
GROUP BY Customers
ORDER BY TotalSales DESC
LIMIT 5;


#Which product has the highest profit margin?
SELECT Product, (Profit/Sales) AS ProfitMargin
FROM sample
group by product
ORDER BY ProfitMargin DESC;


#What is the total sales and profit for each year?

SELECT YEAR(OrderDate) AS Order_Year, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM sample
GROUP BY Order_Year;

#How many orders were placed in each region?
SELECT Region, COUNT(Orderid) AS TotalOrders
FROM sample
GROUP BY Region;

#What is the average discount for each category?

SELECT Category, round(AVG(Discount)*100,2)AS AverageDiscount
FROM sample
GROUP BY Category;

#Which segment has the highest average profit?

SELECT Segment, AVG(Profit) AS AverageProfit
FROM sample
GROUP BY Segment
ORDER BY AverageProfit DESC
LIMIT 1;

#What are the top 3 shipping modes based on total sales?

SELECT ShipMode, SUM(Sales) AS TotalSales
FROM sample
GROUP BY ShipMode
ORDER BY TotalSales DESC
LIMIT 3;

