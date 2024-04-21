select rating, count(film_id) as liczba
from sakila.film
group by rating;