select title, length, rating
from sakila.film
where rating = 'R'
order by length desc
limit 5;