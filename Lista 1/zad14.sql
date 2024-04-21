select payment.customer_id, payment.rental_id, payment_date, avg(amount)
from sakila.payment
inner join sakila.customer on customer.customer_id = payment.customer_id
group by customer.customer_id
having avg(amount) > (select avg(amount)
from sakila.payment
where payment_date like '2005-07-07%');