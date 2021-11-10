/*Review the tables in the database.
Explore tables by selecting all columns from each table or using the in built 
review features for your client.
*/
show tables;
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

#Select one column from a table. Get film titles.
select title as film_titles from film;

/* Select one column from a table and alias it. 
Get unique list of film languages under the alias language. 
Note that we are not asking you to obtain the language per each film, 
but this is a good time to think about how you might get that information in the future.
*/
select distinct name as film_language from language;

#5.1 Find out how many stores does the company have?
select * from store;
select count(store_id) from store;

#5.2 Find out how many employees staff does the company have?
select * from staff;
select count(staff_id) from staff;

#5.3 Return a list of employee first names only?
select first_name from staff;
