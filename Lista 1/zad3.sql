select film.film_id, film.title, language.language_id, name 
from sakila.film
inner join sakila.language On language.language_id = film.language_id
where description not like '%Documentary%';

/*
select film.film_id,film.title,language.name 
from sakila.film,sakila.language 
where description not like '%Documentary%' and film.language_id=language.language_id
*/