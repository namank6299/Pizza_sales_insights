-- Q. 01. CALCULATE THE PERCENTAGE CONTRIBUTION OF EACH PIZZA CATEGORY TO TOTAL REVENUE.
SELECT 
    pizza_types.category,
    SUM(order_details.QUANTITY * pizzas.price) AS REVENUE,
    CONCAT(ROUND((SUM(order_details.QUANTITY * pizzas.price) / (SELECT 
                            SUM(REVENUE)
                        FROM
                            (SELECT 
                                pizza_types.CATEGORY,
                                    SUM(order_details.QUANTITY * pizzas.price) AS REVENUE
                            FROM
                                pizza_types
                            JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
                            JOIN order_details ON order_details.PIZZA_ID = pizzas.pizza_id
                            GROUP BY pizza_types.CATEGORY) AS REVENUE_TABLE) * 100),
                    2),
            '%') AS PERCENTAGE_DISTRIBUTION_OF_EACH_PIZZA
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY PERCENTAGE_DISTRIBUTION_OF_EACH_PIZZA DESC;

--  Q. 02. ANALYZE THE CUMULATIVE REVENUE GENERATED MONTH OVER MONTH.

SELECT MONTH, MONTHLY_REVENUE,
ROUND(SUM(MONTHLY_REVENUE) OVER (order by MONTH), 2) AS CUMMULATIVE_REVENUE 
FROM
(SELECT month(orders.ORDER_DATE) as MONTH, ROUND(SUM(order_details.QUANTITY * pizzas.PRICE), 2) AS MONTHLY_REVENUE 
FROM order_details JOIN pizzas
ON order_details.PIZZA_ID = pizzas.PIZZA_ID
JOIN orders
ON orders.ORDER_ID = order_details.ORDER_ID
GROUP BY MONTH(ORDERS.ORDER_DATE)) AS MONTHLY_REVENUE_TABLE;


-- Q. 03. DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE FOR EACH PIZZA CATEGORY.

SELECT category, name, REVENUE_PER_CATEGORY_AND_NAME, RANK_NUMBER 
FROM
(SELECT category, name, REVENUE_PER_CATEGORY_AND_NAME, 
RANK() OVER (partition by CATEGORY ORDER BY REVENUE_PER_CATEGORY_AND_NAME DESC) AS RANK_NUMBER
 FROM 
(SELECT pizza_types.category, pizza_types.name, ROUND(SUM(order_details.QUANTITY * pizzas.price), 2) AS REVENUE_PER_CATEGORY_AND_NAME
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name
ORDER BY REVENUE_PER_CATEGORY_AND_NAME DESC) AS RPCN_TABLE) AS RANK_RPCN_TABLE
WHERE RANK_NUMBER <=3;