-- Output the category of movies that have the highest number of total rental hours 
-- in the city (customer.address_id in this city) 
-- and that start with the letter “a”. 
-- Do the same for cities that have a “-” in them. 
-- Write everything in one query.

(
SELECT c.city
     , cut.name as "category"
     , SUM(EXTRACT(epoch FROM r.return_date - r.rental_date)/3600) as "total_rental_hours"
FROM   customer cust
JOIN   rental r
  ON   cust.customer_id = r.customer_id
JOIN   address a
  ON   cust.address_id = a.address_id
JOIN   city c
  ON   a.city_id = c.city_id
JOIN   inventory i
  ON   r.inventory_id = i.inventory_id
JOIN   film f
  ON   i.film_id = f.film_id
JOIN   film_category fc
  ON   f.film_id = fc.film_id
JOIN   category cut
  ON   fc.category_id = cut.category_id
WHERE  c.city LIKE 'a%'
AND    r.return_date IS NOT NULL
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1
)
UNION
(
SELECT c.city
     , cut.name as "category"
     , SUM(EXTRACT(epoch FROM r.return_date - r.rental_date)/3600) as "total_rental_hours"
FROM   customer cust
JOIN   rental r
  ON   cust.customer_id = r.customer_id
JOIN   address a
  ON   cust.address_id = a.address_id
JOIN   city c
  ON   a.city_id = c.city_id
JOIN   inventory i
  ON   r.inventory_id = i.inventory_id
JOIN   film f
  ON   i.film_id = f.film_id
JOIN   film_category fc
  ON   f.film_id = fc.film_id
JOIN   category cut
  ON   fc.category_id = cut.category_id
WHERE  c.city LIKE '%-%'
AND    r.return_date IS NOT NULL
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1
)
/*
   Переписала запрос с условием WHERE.
   Почему я делаю проверку r.return_date IS NOT NULL.
   Я заметила, что есть записи в таблице, где rental_date установлен, а r.return_date - нет.
   Т.е. клиент взял что-то в прокат, но еще не вернул. 
   А я считаю разницу r.return_date - r.rental_date, чтобы установить время проката.
*/