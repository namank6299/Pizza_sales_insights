-- Q. 01. Retrieve the total number of orders placed.
SELECT 
    COUNT(ORDER_ID) AS 'TOTAL ORDERS'
FROM
    ORDERS;

-- Q. 02.  Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(pizzas.PRICE * ORDER_DETAILS.QUANTITY),
            2) AS 'TOTAL REVENUE'
FROM
    pizzas
        JOIN
    ORDER_DETAILS ON pizzas.pizza_id = order_details.PIZZA_ID;

-- Q. 03. Identify the highest-priced pizza.
SELECT 
    PIZZA_TYPES.NAME AS 'HIGHEST PRICED PIZZA', PIZZAS.PRICE
FROM
    PIZZA_TYPES
        JOIN
    PIZZAS ON PIZZA_TYPES.PIZZA_TYPE_ID = PIZZAS.PIZZA_TYPE_ID
ORDER BY PIZZAS.PRICE DESC
LIMIT 1;

-- Q. 04. Identify the most common pizza size ordered.
SELECT 
    pizzas.size AS "PIZZA'S SIZE",
    COUNT(ORDER_DETAILS.ORDER_DETAILS_ID) AS 'ORDER_COUNT'
FROM
    pizzas
        JOIN
    ORDER_DETAILS ON pizzas.pizza_id = order_details.PIZZA_ID
GROUP BY pizzas.size
ORDER BY ORDER_COUNT DESC
LIMIT 1;