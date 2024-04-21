select film.film_id,title,name
from ((sakila.film 
inner join sakila.film_category on film.film_id=film_category.film_id)
inner join sakila.category on film_category.category_id=category.category_id)
where description not like '%Documentary%'
and name like 'Documentary';

/*select film.film_id, film.title, name
from sakila.film, sakila.film_category,sakila.category
where description not like '%Documentary%'
and name like 'Documentary'
and film.film_id=film_category.film_id 
and film_category.category_id=category.category_id
*/