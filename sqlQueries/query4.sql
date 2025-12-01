-- Print the names of movies that are not in the inventory. 
-- Write a query without using the IN operator.

SELECT    DISTINCT f.title
FROM      film f
LEFT JOIN inventory i
       ON f.film_id = i.film_id
WHERE     i.inventory_id IS NULL
ORDER BY 1