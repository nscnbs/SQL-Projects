select  customer_id, count(customer_id) as ilosc_rental /* count(customer_id341) = 23*/
from sakila.rental
group by customer_id
having count(customer_id) >
(select  count(rental.customer_id)
from sakila.customer
join sakila.rental on rental.customer_id = customer.customer_id
where customer.email like 'PETER.MENARD%');