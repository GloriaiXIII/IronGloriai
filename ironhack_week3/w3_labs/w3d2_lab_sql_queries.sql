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

