-- Output cities with the number of active and inactive customers 
-- Sort by the number of inactive customers in descending order.

SELECT DISTINCT c.city 
	 , COUNT(cust.active) FILTER (WHERE cust.active = 1)
	   OVER(PARTITION BY c.city) "active_cust"
	 , COUNT(cust.active) FILTER (WHERE cust.active <> 1)
	   OVER(PARTITION BY c.city) "inactive_cust"
FROM   city c
JOIN   address a
  ON   c.city_id = a.city_id
JOIN   customer cust
  ON   a.address_id = cust.address_id
ORDER BY inactive_cust DESC

	 /*
Решение рабочее, но неоптимальное. Причина в использовании distinct и оконных функций. 
Корректно ли условие cust.active <> 1 ? Что произойдёт если значение будет null?
	*/