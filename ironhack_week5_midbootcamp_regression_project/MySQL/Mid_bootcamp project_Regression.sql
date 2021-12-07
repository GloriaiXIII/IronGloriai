#Mid-bootcamp project - Regression.
#SQL questions - regression


#1. Create a database called house_price_regression.
#we already received created database
use house_price_regression;


#2. Create a table house_price_data with the same columns as given in the csv file.Please make sure you use the correct data types for the columns.
#we just chenge the tables name from 'regression2' to 'house_price_data'
ALTER TABLE regression2  
RENAME TO house_price_data; 


#4. Select all the data from table house_price_data to check if the data was imported correctly
SELECT *
FROM house_price_data;


#5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
ALTER TABLE house_price_data
DROP date;
SELECT * FROM house_price_data
LIMIT 10; 


#6. Use sql query to find how many rows of data you have. 
#17366
SELECT COUNT(*)
FROM house_price_data;


#7. Now we will try to find the unique values in some of the categorical columns: What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms FROM house_price_data
ORDER BY bedrooms; 

# What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms FROM house_price_data
ORDER BY bathrooms; 

# What are the unique values in the column floors?
SELECT DISTINCT floors FROM house_price_data
ORDER BY floors; 

# What are the unique values in the column condition?
SELECT DISTINCT house_price_data.condition FROM house_price_data
ORDER BY house_price_data.condition; 

# What are the unique values in the column grade?
SELECT DISTINCT grade FROM house_price_data
ORDER BY grade; 


#8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
SELECT id
FROM house_price_data
order by price DESC
limit 10;


#9. What is the average price of all the properties in your data?
SELECT AVG(Price) AS AveragePrice FROM house_price_data;


#10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data. What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
SELECT AVG(Price) AS AveragePrice, bedrooms 
FROM house_price_data
group by bedrooms
order by bedrooms;

# What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.
SELECT AVG(sqftliving) AS Average, bedrooms 
FROM house_price_data
group by bedrooms      
order by bedrooms;
        
        
# What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.
SELECT AVG(Price) AS AveragePrice, waterfront 
FROM house_price_data
group by waterfront
order by waterfront;
        
# Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select avg(house_price_data.condition), grade
FROM house_price_data
group by grade
order by grade;

#11. One of the customers is only interested in the following houses:
#Number of bedrooms either 3 or 4
#Bathrooms more than 3
#One Floor
#No waterfront
#Condition should be 3 at least
#Grade should be 5 at least
#Price less than 300000
#For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?
select *
FROM house_price_data
where bedrooms in (3,4)
and bathrooms>3
and floors = 1
and waterfront = 0
and grade >= 5
and  house_price_data.condition >= 3
and price < 300000;


#12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
SELECT * 
FROM house_price_data
WHERE price >= (select avg(price) as total_price from house_price_data)*2;


#13. Since this is something that the senior management is regularly interested in, create a view of the same query.
CREATE VIEW interested AS
SELECT * 
FROM house_price_data
WHERE price >= (select avg(price) as total_price from house_price_data)*2;


#14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
SELECT  bedrooms, avg(price)
FROM house_price_data
WHERE bedrooms IN (3,4) 
GROUP BY bedrooms;


#15. What are the different locations where properties are available in your database? (distinct zip codes)
SELECT zip 
FROM house_price_data
ORDER BY zip; 


#16. Show the list of all the properties that were renovated.
SELECT  *
FROM house_price_data
WHERE renovated > 0;


#17. Provide the details of the property that is the 11th most expensive property in your database.
SELECT  *
FROM house_price_data
order BY price desc
limit 11;
select *
FROM house_price_data
where id = 6065300370;


