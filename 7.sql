WITH film_rentals AS (
	SELECT inventory.film_id, COUNT(*)
	FROM rental
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	GROUP BY inventory.film_id),
	category_rentals AS (
	SELECT film_category.category_id, SUM(film_rentals.count)
	FROM film_category
	JOIN film_rentals ON film_rentals.film_id = film_category.film_id
	GROUP BY film_category.category_id)
	
SELECT category.*, category_rentals.sum
FROM category
JOIN category_rentals ON category_rentals.category_id = category.category_id
ORDER BY category_rentals.sum DESC
