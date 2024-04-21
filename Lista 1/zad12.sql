select distinct last_name
from ((sakila.film
inner join sakila.film_actor fa on film.film_id=fa.film_id)
inner join sakila.actor on fa.actor_id=actor.actor_id)
where fa.film_id not between 
(select min(film_id)
from sakila.film
where title like 'B%') and 
(select max(film_id)
from sakila.film
where title like 'B%')