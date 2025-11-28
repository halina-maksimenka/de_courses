-- Output the top 3 actors who have appeared the most in movies in the “Children” category. 
-- If several actors have the same number of movies, output all of them.

-- movies in the “Children” category
WITH movies AS
(
   SELECT f.film_id as "film_id"
   FROM   film f
   JOIN   film_category fc
     ON   f.film_id = fc.film_id
   JOIN   category cat
     ON   fc.category_id = cat.category_id
    AND   cat.name LIKE 'Children' /* оптимальнее будет = 'Children' */
 ),
 -- number of films for actors in the “Children” category
number_of_films AS
(
SELECT DISTINCT a.first_name as "first_name" /* использовать дистинкт в запросе с групп бай может быть излишне. попробуй без него и сравни результаты */
       , a.last_name as "last_name"
	   , COUNT(fa.film_id) as "count_films"
FROM   actor a
JOIN   film_actor fa
  ON   a.actor_id = fa.actor_id
JOIN   movies 
  ON   fa.film_id = movies.film_id
GROUP BY 1, 2
),
-- dense_rank
rank_all_actors AS
(
   SELECT *
	    , DENSE_RANK() OVER(
          ORDER BY count_films DESC
     ) rank
   FROM number_of_films
)
-- the top 3 actors
SELECT *
FROM rank_all_actors
WHERE rank < 4

