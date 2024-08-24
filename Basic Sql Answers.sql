-- Basic Questions

-- 1.Retrieve the total number of orders placed.
SELECT count(ORDER_ID) AS TOTAL FROM ORDERS;

-- 2.Calculate the total revenue generated from pizza sales.
SELECT sum(pizzas.PRICE*order_details.quantity) AS REVENUE
FROM order_details
INNER JOIN pizzas ON pizzas.pizza_id=order_details.pizza_id;

-- 3.Identify the highest-priced pizza.
select PIZZA_TYPES.NAME,PIZZAS.PRICE FROM PIZZA_TYPES
INNER JOIN PIZZAS ON PIZZAS.PIZZA_TYPE_ID=PIZZA_TYPES.PIZZA_TYPE_ID
ORDER BY PIZZAS.PRICE DESC LIMIT 1;

-- 4.Identify the most common pizza size ordered.
select pizzas.size as common_pizza,count(order_details.order_id) as cnt
from pizzas inner join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizzas.size
order by cnt desc limit 1;

-- 5.List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,sum(order_details.quantity) as Q from pizza_types
inner join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id
inner join order_details on order_details.pizza_id=pizzas.pizza_id 
inner join orders on orders.order_id=order_details.order_id
group by pizza_types.name
order by Q desc limit 5;