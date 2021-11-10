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

# Friday class review ---------------------------------------------------------------------------------------------------------------------
# AS detailed window -  AS detailed window -  AS detailed window -  AS detailed window -  AS detailed window
select loan_id, account_id, amount, payments, duration, amount-payments as balance,
avg(amount-payments) over (partition by duration) as Avg_Balance
from bank.loan
where amount > 100000
order by duration, balance desc;

# a group by summary - group by - group by - group by - group by - group by - group by - group by - group by 
select duration, count(loan_id), count(account_id), sum(amount),
sum(payments), avg(amount-payments) as avgbal
from bank.loan
where amount > 10000
group by duration;

# window fx - ranking - within each term who has the biggest / smallest bal - RANK - RANK - RANK - RANK - RANK - RANK
select loan_id, account_id, amount, payments, 
duration, amount-payments as balance,
rank() over (partition by duration order by amount DESC) as rankingbyterm
from bank.loan
where amount > 100000
order by rankingbyterm, duration, balance desc
limit 5;


# w4day1 JOINS ---------------------------------------------------------------------------------------------------------------------
# JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS JOINS
select * from account t1
join account t2
on t1.account_id <> t2.account_id 
and t1.district_id = t2.district_id
order by t1.district_id, t1.account_id;
# (like a cross join) - we have everything joined to everything

# disp - slightly strange information?
#for each account the owner and disponent (legal authority)
SELECT 
    *
FROM
    disp d1
        JOIN
    disp d2 ON d1.account_id = d2.account_id
        AND d1.type <> d2.type
WHERE
    d1.type = 'Disponent';

CREATE VIEW owner_info AS
    SELECT 
        d1.account_id AS account,
        d1.type AS primaryrol,
        d1.client_id AS disponent_client_id,
        d2.client_id AS owner_client_id,
        cl.birth_number AS ownerbirthnumber
    FROM
        disp d1
            JOIN
        disp d2 ON d1.account_id = d2.account_id
            AND d1.type <> d2.type
            JOIN
        client cl ON d2.client_id = cl.client_id
    WHERE
        d1.type = 'Disponent';

select * from owner_info;


# write the inner query first - and check it ! - pseudo code to sketch out the whole query - space your query out over a few rows ((()))
/*loans which are bigger than average of all loans
inner query 1st 
get the loan id
where loanamount is bigger than 
avg loans all*/

SELECT 
    AVG(amount)
FROM
    loan;
# a subquery
SELECT 
    loan_id, amount, duration, status
FROM
    loan
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            loan)
ORDER BY amount DESC
limit 10
;

# Find out the average number of transactions by account. 
# Get those accounts that have more transactions than the average.
select * from trans;
select account_id, count(trans_id) as num_trans
from trans
group by account_id;

select t.account_id, count(t.trans_id) as num_trans,
a.district_id, a.frequency from trans t
join account a using (account_id)
group by t.account_id, a.district_id, a.frequency
having count(t.trans_id) >
(select floor(avg(num_trans)) from
(select account_id,
count(trans_id) as num_trans from trans
group by account_id) s1)
order by num_trans;

# get a list of accounts from Central Bohemia - using a subquery
select * from account
where district_id in 
(select A1 from district
where A3 = 'central Bohemia');

# create a view of ...
# list of bad loans - based on status B and D 
# summary of each region, district, with the no of accounts 
# empl rate 
create view badloansdistrict as 
select count(a.account_id) as noofaccounts,  d.A2 as districtname,
d.A3 as regionname, round(avg(d.A13),1) as unemplrate
from district d
join account a 
on d.A1 = a.district_id
inner join 
(select distinct account_id from loan where status in ('B','D')) s1
using (account_id)
group by districtname, regionname
; 

# w4day2 connect python and mysql ---------------------------------------------------------------------------------------------------------------------
use bank;

select a.account_id, a.frequency, c.client_id, c.district_id
from account a
join disp d 
using (account_id)
join client c
using (client_id)
where type = 'OWNER';

#trans loan disp
select l.status, date_format(convert(t.date,date),'%Y-%m') as date, #gives us month and year
count(distinct t.account_id) as noofaccounts, count(distinct t.trans_id) as nooftrans, ceiling(sum(t.amount)) as movedamount,
count(distinct d.client_id) as noofclients
from trans t #for transactions
join disp d using (account_id) #allows us to get clients
join loan l using (account_id) #allows us to get status
where d.type = 'OWNER'
group by l.status, date_format(convert(t.date,date),'%Y-%m');

# create a view - create a view - create a view - create a view - create a view - create a view - create a view - create a view - create a view - 
#this is monthly unique accounts which made transactions - user_activity
create or replace view user_activity as 
select account_id, 
if(l.status in ('A','C'),'goodloans','badloans') as statusnew,
#(CASE WHEN l.status in ('A','C') THEN 'goodloans' else 'badloans'end) as statusnew, #another way of doing the same as in the IF function before
date_format(convert(t.date,date),'%Y-%m') as activityyearmonth,
date_format(convert(t.date,date),'%Y') as activityyear,
date_format(convert(t.date,date),'%m') as activitymonth
from trans t
join loan l using (account_id)
order by activityyear, activitymonth, statusnew;

# year month unique account id count - monthly_active_users
create or replace view monthly_active_users as
select activityyearmonth, activityyear, activitymonth,
count(distinct account_id) as activeusers, statusnew
from user_activity
group by activityyearmonth, activityyear, activitymonth, statusnew;

#includes LAG -allow to compare MoM - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG - LAG
create or replace view monthonmonth_users as 
select *,
lag(activeusers,1) over (partition by statusnew) as prevmonth
from monthly_active_users; 



