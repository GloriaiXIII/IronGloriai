# LAB | Week 3 Day 2 ---------------------------------------------------------------------------------------------------------------------------------------------------
use sakila;

select * from actor;
select * from address;
select * from category;
select * from city;
select * from country;
select * from customer;
select * from film;
select * from film_actor;
select * from film_category;
select * from film_text;
select * from inventory;
select * from language;
select * from payment;
select * from rental;
select * from staff;
select * from store;

#Select all the actors with the first name ‘Scarlett’.
select * from actor;
select * from actor where first_name LIKE 'SCARLETT';

#How many films (movies) are available for rent and how many films have been rented?
select count(*) as rented from sakila.rental
where rental_date is not null and return_date is null ;
select count(*) as available from sakila.rental
where return_date is not null;

#What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration from film ;

#What's the average movie duration expressed in format (hours, minutes)?
#way A
select CONCAT(FLOOR(avg(length)/60),'h ',round(MOD(avg(length),60)),'m') as avg_mov_duration from film;
#way B
select floor(avg(length)/60) as hours,
round(avg(length)%60) as minutes
from sakila.film;
#way C
select
time_format(sec_to_time(ceiling(avg(length))*60), '%H hours, %i minutes')
as avg_duration
from sakila.film;

#How many distinct (different) actors' last names are there?
select count(last_name) as distinct_last_names from actor;

#Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(last_update),MIN(rental_date)) as operatingdays from rental;

#Show rental info with additional columns month and weekday. Get 20 results.
select
	*, 
	month(rental_date) as rent_month, 
	month(return_date) as return_month,
	weekday(rental_date) as rent_weekday, 
	weekday(return_date) as return_weekday
from rental
limit 20;
/*
select *,
(
   CASE WHEN MONTH(rental_date) BETWEEN 01 AND 01 THEN 01
      WHEN MONTH(rental_date) BETWEEN 02 AND 02 THEN 02
      WHEN MONTH(rental_date) BETWEEN 03 AND 03 THEN 03
      WHEN MONTH(rental_date) BETWEEN 04 AND 04 THEN 04
      WHEN MONTH(rental_date) BETWEEN 05 AND 05 THEN 05
      WHEN MONTH(rental_date) BETWEEN 06 AND 06 THEN 06
      WHEN MONTH(rental_date) BETWEEN 07 AND 07 THEN 07
      WHEN MONTH(rental_date) BETWEEN 08 AND 08 THEN 08
      WHEN MONTH(rental_date) BETWEEN 09 AND 09 THEN 09
      WHEN MONTH(rental_date) BETWEEN 10 AND 10 THEN 10
      WHEN MONTH(rental_date) BETWEEN 11 AND 11 THEN 11
      WHEN MONTH(rental_date) BETWEEN 12 AND 12 THEN 12
   else 00
      end
) as rent_month
from rental
limit 20;
*/

#Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select *,
weekday(rental_date) as weekday,
CASE
WHEN (weekday(rental_date) >= 6) THEN 'weekend'
ELSE 'workday'
end
as day_type
from rental
end;

#How many rentals were in the last month of activity?
SELECT count(*) as lastmonth_rentals FROM rental
WHERE rental_date >= '2006-01-15' AND rental_date <= '2006-02-15';

# LAB | Week 3 Day 3 ---------------------------------------------------------------------------------------------------------------------------------------------------
use sakila;

# Get release years.
select distinct release_year
from film;

# Get all films with ARMAGEDDON in the title.
select * from film;

select *, title
from film
where title LIKE '%ARMAGEDDON%';

# Get all films which title ends with APOLLO.
select * from film;

select *, title
from film
where title LIKE '%APOLLO';

# Get 10 the longest films.
select *,length 
from film
order by length DESC
limit 10;

# How many films include Behind the Scenes content?
select count(special_features)
from film
where special_features LIKE '%Behind the Scenes%';

# Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;
select * from staff;

#A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT into staff (staff_id,first_name,last_name,address_id,store_id,active,username)
VALUES (3,'Tammy','Sanders',4,2,1,'Tammy');

UPDATE staff SET email = 'Tammy.Sanders@sakilastaff.com'
where staff_id = 3;

select * from staff;


/*Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
You can use current date for the rental_date column in the rental table. 
Hint: Check the columns in the table rental and see what information you would need to add there. 
You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
To get that you can use the following query:
	select customer_id from sakila.customer
	where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
# Use similar method to get inventory_id, film_id, and staff_id.
*/
select * from rental;
select * from staff;
select * from inventory;

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
select * from sakila.inventory
where film_id = 1 and store_id = 1;

INSERT into rental (rental_date,inventory_id,customer_id,staff_id)
VALUES (CURRENT_DATE,1,130,1);

select * from rental
where rental_id=16050;


/* Delete non-active users, but first, create a backup table deleted_users 
to store customer_id, email, and the date for the users that would be deleted. 
Follow these steps:
	Check if there are any non-active users
	Create a table backup table as suggested
	Insert the non active users in the table backup table
	Delete the non active users from the table customer
*/
select * from customer;
	#	Check if there are any non-active users
select * from customer
where active = 0;
	# 	Create a table backup table as suggested
drop table if exists sakila.deleted_users;
create table deleted_users (
deleted_user_id INT AUTO_INCREMENT NOT NULL, 
customer_id INT DEFAULT NULL,
email VARCHAR(50) DEFAULT NULL, 
create_date DATETIME DEFAULT NULL,
PRIMARY KEY (deleted_user_id)
);

/*ALTER TABLE deleted_users
ADD FOREIGN KEY (customer_id) REFERENCES customer_id(customer_id);*/

	# Insert the non active users in the table backup table
INSERT INTO deleted_users (customer_id, email, create_date)
SELECT customer_id, email, create_date FROM customer
WHERE active=0;

select * from deleted_users;

	# Delete the non active users from the table customer
DELETE FROM customer 
WHERE active = 0;


# LAB | Week 3 Day 4 ---------------------------------------------------------------------------------------------------------------------------------------------------
use sakila;

# List number of films per category.
select * from category;
SELECT c.name as category_name, count(fc.category_id) as category_id  
FROM category c 
LEFT JOIN film_category fc 
ON c.category_id = fc.category_id 
GROUP by c.name, c.category_id;

# Display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address_id from staff;
select concat(first_name , ' ' , last_name , ' ' , address_id) as film_staff from staff;

# Display the total amount (sum amount) rung up by each staff (staff_id) member in August of 2005 (payment_date).
select staff_id, sum(amount) as sum_amount, payment_date
from payment
WHERE MONTH(payment_date) = 8 AND YEAR(payment_date) = 2005
group by staff_id;

# List each film (film_id from film_actor and film_id from film) and the number of actors (actor_id from film_actor) who are listed for that film.
select fa.film_id,  f.title, count(distinct f.film_id) as noofactors
from film_actor fa
join film f
on fa.film_id = f.film_id
group by fa.actor_id;

# Using the tables payment and customer and the JOIN command, list the total paid sum(p.amount) by each customer (group by p.customer_id). 
# List the customers alphabetically (order by) by last name (c.last_name).
select p.customer_id, sum(p.amount) as total_paid_sum, c.last_name
from payment p
join customer c
on p.customer_id = c.customer_id
group by p.customer_id
order by c.last_name;

# REVIEW | Week 3 Day 5 ---------------------------------------------------------------------------------------------------------------------------------------------------
# is academy dinosaur available for rent from store 1?
use sakila;
select * from film
join inventory using (film_id)
join store using (store_id)
join staff using (store_id)
join rental using (inventory_id)
where title = 'Academy Dinosaur' and store_id = 1;

# LAB | Week 4 Day 1 ---------------------------------------------------------------------------------------------------------------------------------------------------
use sakila;
# How many copies of the film Hunchback Impossible exist in the inventory system?
	# way 1 of solving it - two different orders 
Select f.title, f.film_id From film f
where f.title = "Hunchback Impossible";
select * from inventory
where film_id = 439;
	# way 2 of solving it - one order without subqueries
select f.title, f.film_id, count(f.film_id) as noofcopies
from film f 
inner join inventory i 
on f.film_id = i.film_id 
where f.title = 'Hunchback Impossible';
	# way 3 of solving it - using subquery
select count(*) as noofcopies from inventory i
where i.film_id in 
(select f.film_id from film f
where f.title = 'Hunchback Impossible');

# List all films whose length is longer than the average of all the films.
#SELECT floor(AVG(f.length)) as avg_length from film f; #115min
SELECT f.film_id, f.title, f.length
from film f
where f.length >
(SELECT floor(AVG(f.length)) from film f)
order by f.length DESC;

# Use subqueries to display all actors who appear in the film Alone Trip.
select fa.actor_id, fa.film_id, 
concat(a.first_name, ' ', a.last_name) as actors_name, 
f.title
from film_actor fa
join actor a using (actor_id)
join film f using (film_id)
where fa.film_id in 
(select f.film_id from film f
where f.title = 'Alone Trip');

# Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
# Identify all movies categorized as family films.
select f.film_id, f.title
from film f
join film_category fc on 
f.film_id = fc.film_id
join category c on 
fc. category_id = c.category_id
where c.name in
(select c.name from category c
where c.name = 'Family');

/* Get name and email from customers from Canada using subqueries. 
Do the same with joins. Note that to create a join, you will have to identify 
the correct tables with their primary keys and foreign keys, that will help 
you get the relevant information.
*/
	# without subqueries
SELECT CONCAT(c.first_name, ' ',c.last_name) as full_name, c.email, co.country, ci.city, a.address_id
FROM customer c
LEFT JOIN address a ON (c.address_id = a.address_id)
LEFT JOIN city ci ON (a.city_id = ci.city_id)
LEFT JOIN country co ON (ci.country_id = co.country_id)
WHERE country='Canada';
	# with subqueries 
SELECT CONCAT(c.first_name, ' ',c.last_name) as full_name, c.email, co.country, ci.city, a.address_id
FROM customer c
LEFT JOIN address a ON 
(c.address_id = a.address_id)
LEFT JOIN city ci ON 
(a.city_id = ci.city_id)
LEFT JOIN country co ON 
(ci.country_id = co.country_id)
WHERE co.country in
(select co.country from country co
where co.country='Canada');

/* Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has 
acted in the most number of films. First you will have to find the most prolific actor and then use that 
actor_id to find the different films that he/she starred.*/
select f.title, fa.actor_id
from film f
join film_actor fa using (film_id)
where actor_id =
(SELECT a.actor_id
FROM actor a
LEFT JOIN(
SELECT COUNT(fa.film_id) AS nooffilms, fa.actor_id
FROM film_actor fa
GROUP BY fa.actor_id) AS num ON (a.actor_id=num.actor_id)
ORDER BY num.nooffilms DESC
LIMIT 1);

/* Films rented by most profitable customer. You can use the customer table 
and payment table to find the most profitable customer ie the customer that 
has made the largest sum of payments
*/
SELECT DISTINCT f.title AS films_rented, p.customer_id, 
CONCAT(c.first_name, ' ',c.last_name) as most_profitable_customer
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN customer c using (customer_id)
JOIN payment p USING (customer_id)
WHERE p.customer_id = 
(SELECT p.customer_id FROM payment p
GROUP BY p.customer_id
ORDER BY SUM(p.payment_id) DESC
LIMIT 1);

#Customers who spent more than the average payments.
SELECT CONCAT(c.first_name, ' ',c.last_name) as customer_name, c.customer_id, sum(p.amount) as sum_amount
FROM customer c
JOIN payment p using (customer_id)
WHERE c.customer_id IN 
(SELECT DISTINCT c.customer_id
FROM payment p
WHERE p.amount > 
(SELECT AVG(p.amount)
FROM payment p))
group by c.customer_id 
order by sum_amount DESC;


# LAB | Week 4 Day 2 ---------------------------------------------------------------------------------------------------------------------------------------------------
use sakila;
/*#### Create a query to get the list of films and a boolean indicating if it was rented last month. This would be our target variable.
*/
select rental_date from rental
order by rental_date desc; #2006-02-14

select f.title, r.rental_date
from film f
join inventory i using (film_id)
join rental r using (inventory_id) 
WHERE r.rental_date in
(select r.rental_date from rental r
where r.rental_date>='2006-01-15%' AND r.rental_date<='2006-02-15%');

create or replace view film_rent_lab as 
select i.inventory_id, 
r.rental_id, r.rental_date, r.customer_id as rent_customer_id, r.return_date,
f.film_id, f.title, f.release_year, f.rental_duration, f.rental_rate,  
f.length, f.replacement_cost, f.rating, p.amount, p.payment_date
from film f 
join inventory i using (film_id) 
join rental r using (inventory_id)
join payment p using (rental_id);


