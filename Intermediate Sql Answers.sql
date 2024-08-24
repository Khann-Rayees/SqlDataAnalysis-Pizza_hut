-- Intermediate Questions

-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT sum(order_details.quantity) as total, pizza_types.category as category from order_details
inner join pizzas on pizzas.pizza_id=order_details.pizza_id
inner join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id
group by category
order by total desc;

-- 2.Determine the distribution of orders by hour of the day.
select count(orders.order_id) as total, hour(orders.time) from orders
group by hour(orders.time)
order by total desc;

-- 3.Join relevant tables to find the category-wise distribution of pizzas.
select count(pizza_types.category), pizza_types.category from pizza_types
group by pizza_types.category
order by 1 desc;

-- 4.Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(total) from
(select orders.date,sum(order_details.quantity) as total from order_details
inner join orders on orders.order_id=order_details.order_id
group by orders.date
order by total) as order_quantity;

-- 5.Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name, sum(order_details.quantity*pizzas.price) as revenue from pizza_types
inner join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id
inner join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3;

