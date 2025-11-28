--Output the category of movies on which the most money was spent.

-- amount for inventories
WITH inv_amount AS
( 
   SELECT r.inventory_id as "inventory_id",
          i.film_id as "film_id",
		  SUM(p.amount) as "amount"
   FROM   rental r
   JOIN   payment p
     ON   r.rental_id = p.rental_id
   JOIN   inventory i
     ON   r.inventory_id = i.inventory_id
   GROUP BY 1, 2
),
-- how much money on movies was spent
money_movies AS
(
   SELECT film_id, 
          SUM(amount) as "money"
   FROM   inv_amount
   GROUP BY film_id
)
--Output the category of movies
SELECT cat.name as "category of movies"
FROM   category cat
JOIN   film_category fc
  ON   cat.category_id = fc.category_id
JOIN   film f
  ON   f.film_id = fc.film_id
JOIN   money_movies 
  ON   f.film_id = money_movies.film_id
ORDER BY money_movies.money DESC
LIMIT 1

	 /*
Решение не соответствует условию
	*/