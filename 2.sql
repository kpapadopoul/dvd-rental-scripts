WITH total_inventory_count AS (
	SELECT inventory.store_id, inventory.film_id, COUNT(*)
	FROM inventory
	GROUP BY inventory.store_id, inventory.film_id),
	rented_inventory_count AS (
	SELECT inventory.store_id, inventory.film_id, COUNT(*)
	FROM rental
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	WHERE rental_date <= '2005-07-29' AND return_date > '2005-07-29'
	GROUP BY inventory.store_id, inventory.film_id),
	available_inventory_count AS (
	SELECT total_inventory_count.store_id, total_inventory_count.film_id, (total_inventory_count.count - rented_inventory_count.count) as available
	FROM total_inventory_count
	JOIN rented_inventory_count ON total_inventory_count.store_id = rented_inventory_count.store_id
		AND total_inventory_count.film_id = rented_inventory_count.film_id),
	total_films AS (
	SELECT total_inventory_count.store_id, COUNT(*)
	FROM total_inventory_count
	GROUP BY total_inventory_count.store_id),
	available_films AS (
	SELECT available_inventory_count.store_id, COUNT(*)
	FROM available_inventory_count
	WHERE available > 0
	GROUP BY available_inventory_count.store_id)
	
SELECT total_films.store_id, (CAST(total_films.count AS FLOAT) - CAST(available_films.count AS FLOAT)) / CAST(total_films.count AS FLOAT) * 100
FROM total_films
JOIN available_films ON total_films.store_id = available_films.store_id

