/*alter table sakila.language
add films_no varchar(255);
*/

update sakila.language
set films_no = (select sum(film.language_id = '1') from sakila.film)
where language_id > 0 
and name = 'English';

update sakila.film 
set language_id = '4' 
where title like 'WON DARES';

update sakila.language 
set films_no = (select sum(film.language_id = 4) 
from sakila.film) 
where language_id > 0 
and name = 'Mandarin';

update sakila.film 
set language_id = "6"  
where film_id = (select * from (select film.film_id 
from sakila.film_actor, sakila.actor 
where (film_actor.film_id = film.film_id) 
and (film_actor.actor_id = actor.actor_id ) 
and (actor.first_name like 'NICK') 
and (actor.last_name like 'WAHLBERG'))as x) 
and (film.film_id > 0);

update sakila.language 
set films_no = (select sum(film.language_id = 6) 
from sakila.film) 
where language_id > 0 
and name = 'German';

select *
from sakila.language

/*
UPDATE sakila.film
SET language_id = "6" 
where film_id = (select * from( select film.film_id
from ((sakila.film
inner join sakila.film_actor on film_actor.film_id = film.film_id)
inner join sakila.actor on actor.actor_id = film_actor.actor_id)
where actor.first_name like 'NICK' and actor.last_name like 'WAHLBERG') AS x)
and (sakila.film.film_id > 0);

update sakila.film 
set language_id = "6"
where film_id = (  
select film.film_id
from ((sakila.film
inner join sakila.film_actor on film_actor.film_id = film.film_id)
inner join sakila.actor on actor.actor_id = film_actor.actor_id)
where actor.first_name like 'NICK' and actor.last_name like 'WAHLBERG');

UPDATE sakila.film
SET language_id = "6" 
where film_id = (select * from (select film.film_id
from ((sakila.film
inner join sakila.film_actor on film_actor.film_id = film.film_id)
inner join sakila.actor on actor.actor_id = film_actor.actor_id)
where actor.first_name like 'NICK' and actor.last_name like 'WAHLBERG') as t4)
and (film.film_id > 0);
*/