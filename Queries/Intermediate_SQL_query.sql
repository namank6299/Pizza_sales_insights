-- Q. 01. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category AS 'PIZZA_CATEGORY',
    SUM(ORDER_DETAILS.QUANTITY) AS 'QUANTITY_ORDERED'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY category;

-- Q. 02. Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(ORDER_TIME) AS 'HOURLY_ORDER',
    COUNT(orders.ORDER_ID) AS 'QUANTTY_ORDERED'
FROM
    ORDERS
GROUP BY HOURLY_ORDER
ORDER BY HOURLY_ORDER
;

-- Q. 03. find the category-wise distribution of pizzas.
SELECT CATEGORY as PIZZA_CATEGORY, COUNT(NAME) AS 'NUMBER_OF_PIZZA_IN_EACH_CATEGORY' FROM pizza_types
group by category;


-- Q. 04. GROUP THE ORDERS BY MONTH AND CALCULATE THE NUMBER OF PIZZAS ORDERED PER MONTH.
SELECT 
        MONTH(orders.ORDER_DATE) AS MONTH_IN_NUMBER,
            SUM(order_details.QUANTITY) AS 'PIZZA_ORDERED'
    FROM
        orders
    JOIN order_details ON orders.ORDER_ID = order_details.ORDER_ID
    GROUP BY MONTH(orders.ORDER_DATE);
    
-- Q. 05. DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE.

SELECT 
    pizza_types.name AS 'PIZZA_NAME',
    SUM(order_details.QUANTITY * pizzas.price) AS 'REVENUE'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY REVENUE DESC
LIMIT 3;

-- Q. 06. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name AS 'PIZZA NAME',
    SUM(order_details.QUANTITY) AS 'ORDERED_QUANTITY'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY ORDERED_QUANTITY DESC
LIMIT 5;