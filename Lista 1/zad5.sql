select film.film_id, actor.actor_id, first_name, last_name, film.special_features
from ((sakila.film
inner join sakila.film_actor on film.film_id=film_actor.film_id)
inner join sakila.actor on film_actor.actor_id=actor.actor_id)
where special_features like '%Deleted scenes%';

/* with no duplicate
select distinct first_name, last_name
from ((sakila.film
inner join sakila.film_actor on film.film_id=film_actor.film_id)
inner join sakila.actor on film_actor.actor_id=actor.actor_id)
where special_features like '%Deleted scenes%'
*/

/*select film.film_id, actor.actor_id, first_name, last_name, film.special_features
from sakila.film, sakila.film_actor, sakila.actor 
where special_features like '%Deleted scenes%'
and film.film_id=film_actor.film_id 
and film_actor.actor_id=actor.actor_id
*/