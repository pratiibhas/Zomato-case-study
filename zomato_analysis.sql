-- Q1 To find total number of users
select count(customer_id) as total_users  from customer;
/* 17*/
-- Q1 b) To find users who never ordered

select * from customer where
customer_id not in 
(select customer_id from order_detail)
group by customer_id;
/*1012	gopal kasat	1234567812	19 ABP, pashan, pune
1015	harshad kunjir	1234567815	22 DVK, Uruli, pune*/


-- Q2 What is the total amount each customer spent on zomato

select customer_id, (price_per_unit*quantity ) as Total_amt_spent
from foods f
join order_food o
on f.food_id= o.food_id
group by customer_id
order by customer_id desc;


-- Q3 Customers who made more than 10 orders in a particular month 
select customer_id, count(order_id ) as Orders
from order_detail 
where customer_id in (select customer_id from  order_detail where month(order_time)=10)
group by customer_id ;

-- Q4 Average time to make delieveries
select avg((TIMESTAMPDIFF(minute, order_time, delivered_time ))) as average_delievery_time from order_detail;

/*37.2326 */

-- Q5 Employee with highest rating
select employee_name,max(employee_avg_rating)  from zomato_employee;

-- Q6 Top 10 Employees on basis of  deleieveries times
select e.employee_name, e.employee_avg_rating ,avg(TIMESTAMPDIFF(minute, o.order_time, o.delivered_time ))as Delievery_time
from zomato_employee e
join order_detail o
on o.employee_id =e.employee_id
group by employee_name
order by Delievery_time;


-- Q6 b) Top 10 Employees on basis of employee ratings 
select e.employee_name, e.employee_avg_rating ,avg(TIMESTAMPDIFF(minute, o.order_time, o.delivered_time ))as Delievery_time
from zomato_employee e
join order_detail o
on o.employee_id =e.employee_id
group by employee_name
order by employee_avg_rating;

-- Q7Restaurants where customer ordered more than 3 times
select o.customer_id, c.customer_name, restaurant_id, count(*) as orders, week(order_time)
from order_detail o inner join customer c on o.customer_id = c.customer_id
group by restaurant_id
having orders > 3;
