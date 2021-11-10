# average loan amount by status - need groupby - GROUPBY - GROUPBY - GROUPBY - GROUPBY - GROUPBY - GROUPBY - GROUPBY - GROUPBY - GROUPBY - GROUPBY 
use bank;
select status, floor(avg(amount)) as avgloan
from loan
group by status;
#group by must include all fields in the query

#whats the biggest loan amount in each status and duration - DURATION - DURATION - DURATION - DURATION - DURATION - DURATION - DURATION - DURATION
select * from loan;
select status, duration, max(amount) as avgloan
from loan 
where duration = 36 and status = 'A'
group by status, duration;

select a.frequency, a.district_id, b.duration, b.loan_id
from account a
join loan b
on a.account_id = b.account_id 
where duration = 12 
group by b.loan_id;

#orders - where ksymbol is not blank, return the average amount - K_SYMBOL - K_SYMBOL - K_SYMBOL - K_SYMBOL - K_SYMBOL - K_SYMBOL - K_SYMBOL - K_SYMBOL
select * from bank.order;
select round(avg(amount)) as average 
from bank.order
where not k_symbol = ' '
group by k_symbol
order by average ASC
limit 1;

# Class activites and examples ---------------------------------------------------------------------------------------------------------------------
# get the total amount borrowed by the districtid together with the average loan in that district
select sum(a.amount) as totalamt, round(avg(a.amount)) as avgamt, 
b.district_id as district,
c.A2 as district_name
from loan a
join account b
on a.account_id = b.account_id
join district c
on c.A1 = b.district_id
group by district_name, district_id
order by avgamt desc;

#how many accounts do we have per district id?
select * from district;
select a.district_id as district_id, d.A2 as districtname, d.A3 as region, count(distinct a.account_id) as noofaccts
from account a
join district d
on a.district_id = d.A1
group by a.district_id, districtname, region;

# + no of loans
select a.district_id as district_id, d.A2 as districtname, d.A3 as region, count(distinct a.account_id) as noofaccts,
count(distinct l.loan_id) as noofloans
from account a
join loan l 
using (account_id)
join district d 
on a.district_id = d.A1
group by a.district_id, districtname, region;

# HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING HAVING
select a.district_id as district_id, d.A2 as districtname, d.A3 as region, 
count(distinct a.account_id) as noofaccts,count(distinct l.loan_id) as noofloans
from account a
join loan l 
using (account_id)
join district d 
on a.district_id = d.A1
where a.district_id in (3,4,5)
group by a.district_id, districtname, region
having noofaccts = 10; #we only use having if we have a group by

select a.district_id as district_id, d.A2 as districtname, d.A3 as region, 
sum(l.amount) as totalamt, round(avg(l.amount)) as avgamt
from account a
join loan l 
using (account_id)
join district d 
on a.district_id = d.A1
where a.district_id <> 1 and a.district_id in (3,4,5)
group by a.district_id, districtname
having avg(l.amount) > 10000 #we only use having if we have a group by
order by avgamt desc; 
#rule on having - if you want to use an aggregate field as a condition must use having not where

#having in the first top example
use bank;
select status, floor(avg(amount)) as avgloan
from loan
group by status
having avgloan >= 10000 ;
#group by must include all fields in the query

# 2.07 Activity 4 ---------------------------------------------------------------------------------------------------------------------------------
# Find the districts with more than 100 clients.
select c.district_id, d.A2 as districtname, count(distinct client_id) as noofclients
from client c
join district d #we join it because we need the districtname from district
on c.district_id = d.A1
group by district_id, d.A2
having noofclients>100;

/*
select a.district_id as district_id, d.A2 as districtname, count(distinct a.account_id) as noofaccts
from account a
join district d 
on a.district_id = d.A1
group by a.district_id, districtname
having noofaccts > 100;
*/

# Find the transactions (type, operation) with a mean amount greater than 10000.
select * from trans;

select type, operation, floor(avg(amount)) as avgamount
from trans
group by type, operation
having avgamount >= 10000 ;

# 2.05 Activity 3 ---------------------------------------------------------------------------------------------------------------------------------
# Get card_id and year_issued for all gold cards.
select * from card;
select type as type_card, card_id, 
date_format(convert(substring_index(issued,' ',1), date), "%Y") as year_issued
from card
group by card_id
having type = 'gold'
order by year_issued, card_id ASC;

# When was the first gold card issued? (Year)
select type as type_card, 
date_format(convert(substring_index(issued,' ',1), date), "%Y") as year_issued
from card
group by card_id
having type = 'gold'
order by year_issued asc
limit 1;

/* #Get issue date as:
date_issued: 'November 7th, 1993'
fecha_emision: '07 of November of 1993' */
select type as type_card, card_id, 
date_format(convert(substring_index(issued,' ',1), date), "%M %d %Y") as issued_date,
date_format(convert(substring_index(issued,' ',1), date), "%d of %M of %Y") as fecha_emision,
date_format(convert(substring_index(issued,' ',1), date), "%Y %m %d") as date_order_asc
from card
group by card_id
having type = 'gold'
order by date_order_asc ASC;

#Get different card types.
select type as type_card
from card
group by type_card;

# 2.05 Activity 3 ---------------------------------------------------------------------------------------------------------------------------------
use bank;
create view clients_acc_loans_dist as
select * from client c
join district d
on c.district_id = d.A1
join disp dp
on c.client_id = dp.client_id
join account a
on dp.account_id = a.account_id
join loan l 
on l.account_id = a.account_id;

/* join clients to loans
# bring client id, district id, loan id, account_id, district name, amount of loan
# create a view which stores them 'clients and loans'
*/
create view clients_and_loans as
select c.client_id, dp.account_id, c.district_id, l.loan_id, l.amount, 
dt.A1 as district_id, dt.A2 as district_name
from client c
join disp dp
on c.client_id = dp.client_id
join loan l 
on dp.account_id = l.account_id
join district dt
on c.district_id = dt.A1
where dp.type = 'OWNER';

select * 
from account a1
join account a2
on a1.account_id <> a2.account_id
and a1.district_id = a2.district_id
order by a1.district_id, a1.account_id;

# window function
select loan_id, account_id,
amount, payments, duration, amount-payments as 'balance',
round(avg(amount-payments) over (partition by duration)) as avg_balance
from bank.loan
where amount > 10000
order by duration, balance desc;

# we want to rank the customers based on the amount borrowed in each district (biggest =1
# hint: use your clients_loans view
use bank;
select * , rank() over(partition by district_id order by amount desc) as ranking
from clients_and_loans 
order by district_name; 

