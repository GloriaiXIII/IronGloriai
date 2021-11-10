# average loan amount by status - need groupby
use bank;
select status, duration, floor(avg(amount)) as avgloan
from loan 
group by status, duration
having avgloan > 100000;

# group by must include all fields in the query 
Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'bank.avgloan.duration' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

# whats the biggest loan amount in eaach status and duration 
# eg - A, 36 months 
select status, duration, max(amount) from loan as avgloan
where duration = 36 and status = 'A'
group by status, duration;

# orders - where ksymbol is not blank, return the average amount 
#per ksymbol 
# BONUS which k symbol has the smallest avg amount ?

select k_symbol, round(avg(amount)) as average
 from bank.order
 where not k_symbol = ' '
 group by k_symbol
 order by average ASC
 limit 1;

# how many accounts do we have per district id ? 
select a.district_id, count(distinct a.account_id) as noofaccts,
d.A2 as districtname, d.A3 as region, 
count(distinct l.loan_id) as noofloans
from account a 
join loan l
using(account_id)
join district d
on a.district_id=d.A1
where a.district_id in (3,4,5) 
group by a.district_id, districtname, region
having noofaccts =10;
#order by noofaccts ASC

#if using where incorrectly (related to group by field) 
#Error Code: 1054. Unknown column 'noofloans' in 'where clause'
#Error Code: 1111. Invalid use of group function

-- sqL MODES :
SELECT @@GLOBAL.sql_mode;

SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY';

-- exercises 
#Find the districts with more than 100 clients.
select d.A2 as districtname,
count(distinct c.client_id) as noofclients,
 c.district_id 
from client c
join district d
on c.district_id = d.A1 
group by district_id, d.A2
having noofclients > 100;


#ummuhans : 
select d.A2 as districtname,
count(distinct cl.client_id) as noofcls
from client cl
join district d
on cl.district_id = d.A1
group by cl.district_id, d.A2
having count(distinct client_id)>100
order by noofcls asc;

#Find the transactions (type, operation) with 
#a mean amount greater than 10000.

select type,operation, avg(amount) from trans
group by type, operation
having avg(amount) > 10000; 

#Get card_id and year_issued for all gold cards.
select card_id, 
date_format(convert(SUBSTRING_INDEX(issued, ' ', 1), date), '%Y') as year_issued
from bank.card
where type = 'gold';

#When was the first gold card issued? (Year)

select 
min(date_format(convert(SUBSTRING_INDEX(issued, ' ', 1), date), '%Y')) as year_issued
from bank.card
where type = 'gold';

#Get issue date as:
#date_issued: 'November 7th, 1993'
#fecha_emision: '07 of November of 1993'
select date_format(convert(SUBSTRING_INDEX(issued, ' ', 1), date), '%M %D, %Y') as year_issued,
       date_format(convert(SUBSTRING_INDEX(issued, ' ', 1), date), '%d of %M of %Y') as fecha_emision
from bank.card;
limit 10;
