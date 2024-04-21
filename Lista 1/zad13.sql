select actor.actor_id, last_name
from sakila.actor
where(select count(*) /* ile razy actor.actor_id = film_actor.actor_id */
from (((sakila.film_actor
inner join sakila.film on film.film_id = film_actor.film_id)
inner join sakila.film_category on film_category.film_id = film.film_id)
inner join sakila.category on category.category_id = film_category.category_id)
where name like 'Horror' and actor.actor_id = film_actor.actor_id) >
(select count(*)
from (((sakila.film_actor
inner join sakila.film on film.film_id = film_actor.film_id)
inner join sakila.film_category on film_category.film_id = film.film_id)
inner join sakila.category on category.category_id = film_category.category_id)
where name like 'Action' and actor.actor_id = film_actor.actor_id)
order by actor_id;