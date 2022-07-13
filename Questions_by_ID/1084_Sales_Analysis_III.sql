-- Solution 1: Subquery
select product_id, product_name
from product
where product_id in (
    select product_id
    from sales
    where sale_date between "2019-01-01" and "2019-03-31" 
    and product_id not in (
        select product_id
        from sales
        where sale_date not between "2019-01-01" and "2019-03-31"
    )
) 


-- Solution 2: Join
select product_id, product_name
from Sales join Product
using(product_id)
group by product_id
having sum(sale_date between "2019-01-01" and "2019-03-31") = count(sale_date)
