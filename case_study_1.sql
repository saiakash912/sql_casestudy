create database cs4;
use cs4;

##Q1
select details.product_name,
sum(sales.qty) as sales_counts
from sales inner join product_details as details
on sales.prod_id = details.product_id
group by details.product_name
order by sales_counts desc;

##Q2
select sum(qty*price) as total_amount 
from sales;

#Q3
select sum(qty*price*discount)/100 as total_discount_price
from sales;

#Q4
select count(distinct txn_id) as unique_transaction
from sales;

#Q5
with cte_transaction_products as(
select txn_id,
count(distinct product_id) as product_count
from sales
group by txn_id)
select round(avg(product_count)) as avg_unique_product
from cte_transaction_product; 

#Q6
with cte_transaction_discount as(
select txn_id,
sum(price*qty*discount)/100 as total_discount
from sales
group by txn_id)
select round(avg(total_discount)) as avg_discount
from cte_transaction_discount; 

#Q7
WITH cte_member_revenue AS (
  SELECT member,txn_id,SUM(price * qty) AS revenue
  FROM sales
  GROUP BY member, txn_id
)
SELECT member,ROUND(AVG(revenue), 2) AS avg_revenue
FROM cte_member_revenue
GROUP BY member;

#Q8
select details.product_name,sum(qty*sales.price) as n_discount_revenue
from sales inner join product_details as details
on sales.prod_id = details.product_id
group by details.product_name
order by n_discount_revenue desc
limit 3;

#Q9
select details.segment_id,details.segment_name,
sum(sales.qty) as total_quantity,
sum(sales.qty*sales.price) as total_revenue,
sum(sales.qty*sales.price*sales.discount)/100 as total_discount
from sales inner join product_details as details
on prod_id = product_id
group by details.segment_id,details.segment_name;

#Q10
SELECT 
	details.segment_id,
	details.segment_name,
	details.product_id,
	details.product_name,
	SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY
	details.segment_id,
	details.segment_name,
	details.product_id,
	details.product_name
ORDER BY product_quantity DESC
LIMIT 5;

#Q11
select details.category_name,
sum(sales.qty) as total_quantity,
sum(sales.qty*sales.price) as total_revenue,
sum(sales.qty*sales.price*sales.discount)/100 as total_discount
from sales inner join product_details as details
on sales.prod_id = product_id
group by details.category_name; 

#Q12
SELECT 
	details.category_id,
	details.category_name,
	details.product_id,
	details.product_name,
	SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY
	details.category_id
ORDER BY product_quantity DESC
LIMIT 5;
