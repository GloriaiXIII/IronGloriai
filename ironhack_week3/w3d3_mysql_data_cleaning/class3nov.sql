drop database if exists books; 
create database books;
use books;
drop table if exists books.books; #doing this first because of FK dependency)
drop table if exists books.authors; 
create table authors(
author_id INT AUTO_INCREMENT NOT NULL, 
authorname VARCHAR(30) DEFAULT NULL, 
country VARCHAR(30) DEFAULT NULL, 
PRIMARY KEY (author_id)
);
create table books (
book_id INT AUTO_INCREMENT NOT NULL, 
author_id INT NOT NULL, 
bookname VARCHAR(30), 
PRIMARY KEY (book_id),
KEY idx_fk_author_id (author_id),
CONSTRAINT fk_author_id FOREIGN KEY (author_id) 
REFERENCES authors(author_id) ON DELETE RESTRICT 
ON UPDATE CASCADE
)
# referential integrity 

# mysql version - simpler - see w3 schools
# ADD CONSTRAINT FK_... FOREIGN KEY (_id) REFERENCES table(_id) 

#try 
drop table authors;
Error Code: 3730. Cannot drop table 'authors' referenced by a foreign key constraint 'fk_author_id' on table 'books'.
#this will not work! 

# add some data manually or use data import wizard on the left 
insert into authors (authorname, country) 
VALUES ('D McCandless', 'Britain'),('D Spiegalhalter', 'Britain'),
('H Rosling', 'Sweden'),('C Craido Perez', 'Britain'),
('M Gladwell','USA');

# if you made a mistake ...
UPDATE authors SET country = 'Canada' 
where author_id = 5;

#if you missed one ... 
INSERT into authors (authorname,country) 
VALUES ('Steve Jobs', 'USA');

#if you ran the insert into twice you might have 10 now ...
DELETE FROM authors
WHERE author_id in (6,7,8,9,10);
# or run the create statements again

insert into books (bookname,author_id) VALUES
('the art of statistics',2),('Knowledge is beautiful',1),
('Information is beautiful',1),('Factfulness',3), 
('Invisible women',4),('Outliers',5), ('Blink',5),
('a Biography',6);

# if the column is too short for your data
alter table books modify bookname VARCHAR(50);

select b.bookname, a.authorname, a.country
from books b
join authors a 
on b.author_id = a.author_id;

#short form 
# ...from books b join authors a using(author_id);



