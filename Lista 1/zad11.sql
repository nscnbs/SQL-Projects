select a.film_id, a.actor_id, b.actor_id
from sakila.film_actor as a join sakila.film_actor as b
on a.film_id = b.film_id and a.actor_id < b.actor_id
group by a.actor_id, b.actor_id
having count(a.actor_id)>1
order by a.actor_id desc;