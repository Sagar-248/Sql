# How many burger were ordered
select count(*)  as 'no of order'from runner_orders;
#Q2 How many unique customer order were made
select count(distinct order_id)  as 'unique customer order' from customer_orders;
#Q3 How many sucessful order were made by each runner
SELECT
  runner_id,
  COUNT(DISTINCT order_id) AS successful_orders
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id
ORDER BY successful_orders DESC;
#Q4 How many each type of burger were delivered
SELECT p.burger_name, COUNT(c.burger_id) AS delivered_burger_count
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
JOIN burger_name AS p
 ON c.burger_id = p.burger_id
WHERE r.distance != 0
GROUP BY p.burger_name;

#Q5 How many vegetr and meatlover burger were orderby each customer
SELECT c.customer_id, p.burger_name, COUNT(p.burger_name) AS order_count
FROM customer_orders AS c
JOIN burger_name AS p
 ON c.burger_id= p.burger_id
GROUP BY c.customer_id, p.burger_name
ORDER BY c.customer_id;

#Q6 What was the max no burger delivered in single order
WITH burger_count_cte AS
(
 SELECT c.order_id, COUNT(c.burger_id) AS burger_per_order
 FROM customer_orders AS c
 JOIN runner_orders AS r
  ON c.order_id = r.order_id
 WHERE r.distance != 0
 GROUP BY c.order_id
)
SELECT MAX(burger_per_order) AS burger_count
FROM burger_count_cte;

#q7 For each customer how many burger delivered had atleast one change and how many of have had no changesx
SELECT c.customer_id,
 SUM(CASE 
  WHEN c.exclusions <> ' ' OR c.extras <> ' ' THEN 1
  ELSE 0
  END) AS at_least_1_change,
 SUM(CASE 
  WHEN c.exclusions = ' ' AND c.extras = ' ' THEN 1 
  ELSE 0
  END) AS no_change
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.distance != 0
GROUP BY c.customer_id
ORDER BY c.customer_id;
#Q8 What was the total vol of burger order for each hour of day
SELECT HOUR (order_time) AS hour_of_day, 
 COUNT(order_id) AS burger_count
FROM customer_orders
group by order_time;

#Q9 How many runnerid signed in for week1
SELECT EXTRACT(WEEK from registration_date) AS registration_week,
 COUNT(runner_id) AS runner_signup
FROM burger_runner
GROUP BY EXTRACT(WEEK from registration_date);
#Q10 what was the avg distance travelled for each custome
SELECT c.customer_id, round(AVG(r.distance),2) AS avg_distance
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.duration != 0
GROUP BY c.customer_id;
