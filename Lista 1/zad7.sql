select film.title, rental_date
from ((sakila.film
inner join sakila.inventory on film.film_id = inventory.film_id)
inner join sakila.rental on inventory.inventory_id = rental.inventory_id)
where rental_date between '2005-05-25%' and '2005-05-31%'
order by film.title ASC;

select *
from sakila.film;

select *
from sakila.inventory;

select *
from sakila.rental;