create database pizzahut;

select * from orders;
select * from pizza_types;
select * from pizzas;
select * from order_details;

-- Retrieve total number of orders placed.
select count(order_id) as total_orders from orders;


-- Retrieve unique pizzas names.
select distinct(name) as Pizza_name from pizza_types;


-- Calculate the total revenue generated from pizza sales.
select round(sum(order_details.quantity* pizzas.price),2) as total_revenue from order_details join pizzas where pizzas.pizza_id=order_details.pizza_id; 


-- Identify the highest-priced pizza.
select pizza_types.name,pizzas.price from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id order by pizzas.price desc limit 1 ;


-- Identify the most common pizza size ordered.
select pizzas.size,count(order_details.order_details_id) as common_size from pizzas join order_details on pizzas.pizza_id=order_details.pizza_id group by pizzas.size order by common_size;


-- List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,sum(order_details.quantity) as quantity from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on order_details.pizza_id=pizzas.pizza_id group by pizza_types.name order by quantity desc limit 5;


-- Join the necessary tables to find the total quantity of each pizza category ordered.
select sum(order_details.quantity) as quantity,pizza_types.category from order_details join pizzas on order_details.pizza_id=pizzas.pizza_id join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id group by pizza_types.category order by quantity desc;


-- Determine the distribution of orders by hour of the day.
select hour(time),count(order_id) as order_count from orders group by time;


-- Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name)as name from pizza_types group by category;  


-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(total_quantity),0) from 
(select orders.date,sum(order_details.quantity) as total_quantity from orders join order_details on orders.order_id=order_details.order_id group by orders.date) as order_quantity; 
-- avg quantity of pizzas ordered per day is 138

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,sum(order_details.quantity*pizzas.price) as revenue from pizza_types join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id join order_details on order_details.pizza_id=pizzas.pizza_id group by pizza_types.name order by revenue desc limit 3;


-- Identify the lowest-priced pizza.
select pizza_types.name,pizzas.price from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id order by pizzas.price asc limit 1 ;

