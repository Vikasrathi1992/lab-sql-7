USE sakila;

-- 1.Which last names are not repeated?

Select * from actor;
Select last_name , COUNT(*) as 'count' from sakila.actor
group by last_name
having COUNT(*) = 1;


-- 2.Which last names appear more than once?
Select last_name ,COUNT(*) as 'count' from sakila.actor
group by last_name
having COUNT(*) > 1;


-- 3.Rentals by employee.
Select staff_id , count(rental_id) from rental
group by staff_id;

-- 4.Films by year.
Select * from film;

SELECT release_year,COUNT(film_id) AS number_of_films from sakila.film
group by release_year
order by release_year;


-- 5.Films by rating.
select * from film;
Select rating, count(film_id) AS number_of_films from sakila.film 
group by rating
order by rating;



-- 6.Mean length by rating.

select rating, avg(length) as Mean_of_length from sakila.film
group by rating
order by rating;


-- 7.Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length)) as Mean_of_length from sakila.film
group by rating
having Mean_of_length >= 120;


-- 8.List movies and add information of average duration for their rating and original language.
SELECT * from film;
SELECT title,rating,original_language_id,
avg(length) over (partition by rating , original_language_id) AS average
from sakila.film;


-- 9.Which rentals are longer than expected?
/* select * from film;
select * from rental;
select* from inventory; */

-- Joining rental ,inventory and film tables
SELECT f.film_id ,r.rental_id , f.title, f.rental_duration , datediff(r.return_date , r.rental_date) AS rental_duration_calculated,
if (datediff(r.return_date , r.rental_date) > f.rental_duration , 1 , 0 ) AS 'longer_then_expected'
from film f 
LEFT JOIN
inventory i ON f.film_id = i.film_id
LEFT JOIN
rental r ON r.inventory_id = i.inventory_id
having longer_then_expected = 1;








