SELECT * FROM ORDERS;
select * FROM order_details;
select * FROM pizza_types;
select * FROM pizzas;

-- 1.Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category,
    round(SUM(order_details.quantity * pizzas.price) / (SELECT 
            round(sum(order_details.quantity * pizzas.price),2) AS total_sales
        FROM
            order_details
                JOIN
            pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,2) AS percent
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        INNER JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY percent DESC; 

-- 2.Analyze the cumulative revenue generated over time.
select date, sum(rev) over(order by date) as cum_rev
from
(select orders.date,sum(order_details.quantity*pizzas.price) as rev from orders
inner join order_details on order_details.order_id=orders.order_id
inner join pizzas on pizzas.pizza_id=order_details.pizza_id
group by orders.date
order by 2 desc) as sales;

-- 3.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category,name,revenue from
(select category,name,revenue, rank() over(partition by category order by revenue desc) as rn 
from
(select pizza_types.name,pizza_types.category,sum(order_details.quantity*pizzas.price) as revenue from pizza_types
inner join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id
inner join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name,pizza_types.category
order by revenue desc) as a) as b
where rn <=3;
