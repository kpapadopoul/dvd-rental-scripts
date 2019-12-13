WITH film_rentals AS (
	SELECT inventory.film_id, COUNT(*)
	FROM rental
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	GROUP BY inventory.film_id)
	
SELECT film.*, film_rentals.count
FROM film
JOIN film_rentals ON film.film_id = film_rentals.film_id
ORDER BY film_rentals.count DESC