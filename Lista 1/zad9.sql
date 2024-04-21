select distinct customer.customer_id, customer.first_name, customer.last_name, payment.staff_id
from sakila.customer
inner join sakila.payment on customer.customer_id = payment.customer_id
inner join sakila.staff on staff.staff_id = payment.staff_id
where payment.staff_id<(
select count(staff_id)
from sakila.staff)

/*
select distinct customer.customer_id, first_name, last_name , staff_id
from sakila.customer
inner join sakila.payment on customer.customer_id = payment.customer_id
where staff_id = ANY
  (select staff_id
  from sakila.payment
  where staff_id = 1 or 2)
  
SELECT distinct first_name, last_name, 
CASE
    WHEN staff_id = 1 THEN '1'
    WHEN staff_id = 2 THEN '2'
    ELSE 'both'
END AS staff_id
FROM sakila.customer
inner join sakila.payment on customer.customer_id = payment.customer_id
*/