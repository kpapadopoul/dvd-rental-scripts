WITH actor_rentals AS (
	SELECT film_actor.actor_id, COUNT(*)
	FROM rental
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film_actor ON inventory.film_id = film_actor.film_id
	GROUP BY film_actor.actor_id)
	
SELECT actor.*, actor_rentals.count
FROM actor
JOIN actor_rentals ON actor.actor_id = actor_rentals.actor_id
ORDER BY actor_rentals.count DESC
