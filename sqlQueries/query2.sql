--Output the 10 actors whose movies rented the most, sorted in descending order.
/*
-- movies, that rented the most
WITH movies AS
( 
   SELECT i.film_id as "film_id",
	        COUNT(i.film_id) as "number_of_rents"
   FROM   rental r
   JOIN   inventory i
     ON   r.inventory_id = i.inventory_id
   GROUP BY i.film_id
)
-- 10 actors
SELECT DISTINCT a.first_name,
       a.last_name,
	     movies.number_of_rents
FROM   actor a
JOIN   film_actor fa
  ON   a.actor_id = fa.actor_id
JOIN   film f
  ON   fa.film_id = f.film_id
JOIN   movies 
  ON   f.film_id = movies.film_id
ORDER BY movies.number_of_rents DESC
LIMIT 10
	*/

SELECT   a.first_name
       , a.last_name
	     , COUNT(f.film_id) as "number_of_movies"
FROM   actor a
JOIN   film_actor fa
  ON   a.actor_id = fa.actor_id
JOIN   film f
  ON   fa.film_id = f.film_id
JOIN   inventory i
  ON   f.film_id = i.film_id
JOIN   rental r
  ON   r.inventory_id = i.inventory_id
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10