--Output the number of movies in each category, sorted descending.
SELECT COUNT(f.film_id) as "number of movies",
       cat.name as "category"
FROM   film as f
JOIN   film_category as fcat 
  ON   f.film_id = fcat.film_id
JOIN   category as cat
  ON   fcat.category_id = cat.category_id
GROUP BY cat.name
ORDER BY 1 DESC