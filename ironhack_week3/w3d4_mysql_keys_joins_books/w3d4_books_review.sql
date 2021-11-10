#create dabase
drop database if exists books;
create database books;
use books;

#create tables
drop table if exists books.authors;
create table authors (
author_id INT AUTO_INCREMENT NOT NULL, 
author_name VARCHAR(30) DEFAULT NULL, 
country VARCHAR(30) DEFAULT NULL,
PRIMARY KEY (author_id)
);
drop table if exists books.books;
create table books (
book_id INT AUTO_INCREMENT NOT NULL, 
author_id INT NOT NULL, 
bookname VARCHAR(30),
PRIMARY KEY (book_id),
KEY idx_fk_author_id (author_id),
CONSTRAINT fk_author_id FOREIGN KEY (author_id)
REFERENCES authors(author_id) ON DELETE RESTRICT
ON UPDATE CASCADE
);

# ADD DATA MANUALLY - ADD DATA MANUALLY - ADD DATA MANUALLY - ADD DATA MANUALLY - ADD DATA MANUALLY - ADD DATA MANUALLY - ADD DATA MANUALLY
#if the column is too short
alter table books modify bookname VARCHAR(100);
select * from books;

#add some data manually or use data import wizard on the left
insert into authors (author_name,country) 
VALUES ('Beatriz Gimeno','Spain'),('Carme Valls Llobet','Spain'),('Weike Wang','China'),
('Sylvia Plath','EEUU'),('Jeanette Winterson','United Kingdom'),('Virginia Woolf','United Kingdom'),
('Sally Rooney','Ireland'),('Louise Bryant','EEUU'),('Patricia Highsmith','EEUU'),
('Mikhail Bulgakov','Soviet Union'),('Carme Riera','Mallorca'),('Liudmila Petrushévskaia','Russia'),
('Matt Haig','United Kingdom');

#if you made a mistake...
UPDATE authors SET country = 'Spain'
where author_id = 11;

#if you made a mistake...
INSERT into authors (author_name,country)
VALUES ('Montserrat Roig','Spain');

/*
#if you ran the insert into twice you might have the double
DELETE FROM authors 
WHERE author_id in (5,6,7);
*/

select * from authors;
insert into books (bookname,author_id) VALUES
('History and political analysis of lesbianism',1),('Invisible Women for Medicine',2),('Chemistry',3),
('The Bell Jar',4),('The passion',5),("A room of one's own",6),('Normal people',7),
('Six months in russia',8),('The price of salt',9),('The master and Margarita',10),('Te deix, amor, la mar com a penyora',11),
("There Once Lived a Girl Who Seduced Her Sister's Husband, and He Hanged Himself: Love Stories",12),('Reasons To Stay Alive',13);

insert into books (bookname,author_id) VALUES
('The song of youth',14);
select * from books;

UPDATE books SET bookname = 'The time of Cherries'
where book_id = 15;

# add a column 'i have read it' tinyint (boolean) default false (0)
alter table books
add column I_have_read_it boolean default false;

#fill in the column per your reading history
update books set I_have_read_it = true
where book_id in (2,3,4,5,6,7,8,9,10,11,12,13);

# JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN JOIN
# join books and authors
select * 
from books b
join authors a
on b.author_id = a.author_id;

# join books and authors
select b.bookname, a.author_name, a.country 
from books b
join authors a #join = inner join
on b.author_id = a.author_id;

# join books and authors shortway
select * 
from books b 
right join authors a 
using(author_id);

#when to do left right full join 
insert into authors (author_name,country)
VALUES ('Maria Mercè Marçal','Spain');

select count(distinct author_id) from authors;
select count(distinct author_id) from books;

#types of join 
select * from books inner join authors using (author_id);
select * from books right join authors using (author_id);
select * from books left join authors using (author_id);
#right outer join
select * from books right join authors using (author_id)
where book_id is null;







