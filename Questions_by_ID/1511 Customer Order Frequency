select 
    o.customer_id,c.name
from 
        Orders o 
left join Customers c using(customer_id)
left join Product p using(product_id)
where LEFT(order_date, 7) in ("2020-06","2020-07" ) 
group by customer_id
HAVING SUM(CASE
        WHEN LEFT(order_date, 7) = "2020-06" THEN price * quantity
               ELSE 0
           END) >= 100
AND    SUM(CASE
         WHEN LEFT(order_date, 7) = "2020-07" THEN price * quantity
               ELSE 0
           END) >= 100
