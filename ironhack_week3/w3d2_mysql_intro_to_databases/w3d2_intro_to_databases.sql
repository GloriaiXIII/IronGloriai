#select all (*) the columns where district id is 5
select * from account
where district_id=5;

#select two columns separated by a comma
select account_id, frequency from account
where district_id=5;

#mysql is not case sensitive but sql yes

select * from client;
select A1, A2, A3 from district where A1=50;

# Aliases or aliasing
select d.A1, d.A2, d.A3 from district d where A1=50;
# Aliases trans as tr
select tr.trans_id as transaction, k_symbol,
tr.account_id as acc,
type as 'credit-debit', tr.operation as mode,
tr.amount
from trans tr
where k_symbol = ' '; #here we are looking specifically for one blank space, not nulls, two spaces etc
# Note: It requires double quotation marks or square brackets if the alias name contains spaces 

#LIMIT
select * from trans t
order by t.trans_id
limit 30;
# select contact name as [contact person] from table

#top 10 districts, ordered by the number of inhabitants - challenge
select * from district
order by A4 desc
limit 10;

#top 10 districts, ordered by the number of inhabitants - teacher solution
select d.A2, d.A3, d.A4 as popln from district d
order by A4 DESC
limit 10;

#maths example
select 11 * 4;

#select unique
select distinct d.A1 from district d; #select unique 

#select unique account_id in transaction table and count them using count()
select count(distinct account_id) from trans;

#loan balance (amount - payments), loan balance in EUR - order of big to small - challenge
select *, CONCAT(amount-payments, "€") as loan_balance,
CONCAT((amount-payments)*0.030, "€") as balinEUR from loan
order by loan_balance DESC
limit 100;

#teacher answer
/* select loan_id, status, amount-payments as loanbal,
(amount-payments)*0.030 as balinEUR from loan
where (amount-payments)*0.39 > 15000
AND status = 'B'
order by loan_balance DESC
limit 100;
*/

#where balance in EUR > 1500
select * from loan 
where status in ('B','D') and not duration <> 12;


# checking for understanding 2.04 -------------------------------------------------------------------------------------------------

# The select statement is used as a print command in SQL. Use the select statement to print "Hello World".
select "Hello World!";

# Use the select statement to perform a simple mathematical calculation to add two numbers.
select 4+2;

# Use an appropriate select statement to retrieve a list of unique card types from the bank database. (Hint: You can use DISTINCT function here.)
select distinct c.type from card c;

/* Get a list of all the district names A2 in the bank database. Suggestion is to use the files_for_activities/case_study_extended here 
to work out which column is required here because we are looking for the names of places, not just the IDs. 
It would be great to see the results under the heading district_name. (Hint: Use an alias.). You should have 77 rows.
*/
select distinct d.A2 as district_name from district d;

# Bonus: Revise your query to also show the Region, and limit the results to just 30 rows. 
# Sort the results alphabetically by district name A>Z before selecting the 30.
select distinct d.A2 as district_name from district d
order by A2
limit 30;

# checking for understanding 2.05 -------------------------------------------------------------------------------------------------
# select districts A2 and salaries A11 (from the district table) where salary is greater than 10000. Return columns as district_name and average_salary
select d.A2 as district_name, d.A11 as average_salary from district d
where d.A11 > 10000;

/*Calculate the urban population A4 for all districts. Hint: You are looking for the number of inhabitants and 
the % of urban inhabitants in each district. Return columns as district_name and urban_population.
+ bonus: where A10 < 50
*/
select A2 as district_name, A4 as noofinhabitants, A10 as ratio_ofurban,
round(A4*(A10/100), 2) as urban_population
from district
where A10 < '50';

# class notes -------------------------------------------------------------------------------------------------
#AVG loan amount?
select ceiling(avg(amount)) as avgloan from loan;

#STRING functions
#district name lower case and region name upper case
select lower(d.A2) as district_name, upper(d.A3) as region_name from district d; 

#divides and returns the remainder
select 20%3;

/* dates - dates are stored as numbers
convert number into date
date format options - appear in a certainway
date functions - datediff adddate
*/
SELECT *, convert(a.date,date) as dateopened #convert number into date
FROM account a;

#date format options https://www.w3schools.com/sql/func_mysql_date_format.asp
select*, 
date_format(convert(substring_index(issued,' ',1), date), "%D %M %Y") as date
from card;

#example
SELECT DATE_FORMAT("2017-06-15","%D %M %Y");

select*, 
date_format(convert(substring_index(issued,' ',1), date), "%D %M %Y") 
as date,
date_format(convert(substring_index(issued,' ',1), date), "%w") 
as weekdayno
from card;

# earliest date in the card table?
select min(issued) from card;
select max(issued) from card;

#date functions - datediff adddate
select * from card
where issued between 950101 and 971231;

#datediff 
#adddate
select (datediff(curdate(), 19950628))/365;

select floor((datediff(curdate(), 19950628))/365);
select adddate('19950628', INTERVAL 6 MONTH)

#NULLS 
/*select all rows from the order table where k_symbol is null
*/
SELECT * FROM bank.order
where k_symbol is null;

#count the k_symbols that are a blank space
SELECT count(*) FROM bank.order
where k_symbol = ' ';

select count(*) from trans
where amount is null;

select count(*) from trans
where amount = ' ';

# case statement -----------------------------------------------------------------------------------------------------------------------------------
#replace columns in loan table with business defn
select * ,
case 
when status = 'A' then 'good-repaired'
when status = 'B' then 'default'
when status = 'C' then 'on track'
else 'in debt'
end
as statusdesc
from loan
order by statusdesc, amount DESC;

# searching for stuff in strings - LIKE % $ € ^ | (wildcards) ----------------------------------------------------------------------------------------
select* from district where A3 LIKE 'pra%' or A3 LIKE 'south%'; #searching something that starts with the string pra
select* from district where A3 regexp 'pra|south'; #searching something that starts with the string pra or south
#two ways of doing the same

select* from district where A3 regexp '^c'; #searching something that starts with the string pra or south



