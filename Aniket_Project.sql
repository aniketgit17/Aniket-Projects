use college;
select * from books;
select * from class;
select * from issues;
select * from student;
select * from branch;

-- alter table class modify class_id int primary key;
-- alter table student add std_addr varchar(20) after stu_email ;
/* update student set brnch_id = 1002 where stu_id = 911;
update student set brnch_id = 1002 where stu_id = 912;
update student set brnch_id = 1003 where stu_id = 913;
update student set brnch_id = 1001 where stu_id = 914;
update student set brnch_id = 1002 where stu_id = 915; */

/* Q1. fetch all the students by ascending order of the name (Noraml Questions)*/
select * from student order by stu_name DESC;

/* Q2. How many branches are present for engineering steam? (Normal Questions)*/
select count(1) AS qty from branch where brn_ctg = 'Engineering';

/* Q3. fetch name and email ID of a student who belongs to branch IT */
select stu_name, stu_email from student where brnch_id = (select brn_id from branch where brn_name = 'IT');

/* Q4. fetch name, email ID and branch name of all students */
select s.stu_name,s.stu_email,b.brn_name from student s join branch b
on s.brnch_id = b.brn_id;

/* Q5.
select s.stu_name,s.stu_email,b.brn_name from student s right join branch b
on s.brnch_id = b.brn_id;

/* Q6.
select s.stu_name,s.stu_email,b.brn_name from student s left join branch b
on s.brnch_id = b.brn_id;

/* Q7. find out the student name, email id, book name and date of book issued who issued the book of "Basics Of Science" */
select s.stu_name,s.stu_email, b.book_name, i.isu_date
from student s join issues i on s.stu_id = i.isu_stu_id
join books b on i.isu_book_id = b.book_id
where b.book_name = 'Basics Of Maths';

/*Q8. total price of all books in college */
select sum(book_price) sum_book from books;

/*Q9. find out total books available for each branch */
select count(1), br.brn_name from branch br
join books b on b.book_brn_id = br.brn_id
group by br.brn_name;

/*Q10. Name of books issued after year 2021 */
select b.book_name,i.isu_date from books  b
Join issues i on b.book_id = i.isu_book_id
where year(isu_date) > '2021';

/*Q11. Find out the branch name which has more than 2 books also show the respective book count */
select count(1) as book_count, br.brn_name from branch br
join books b on b.book_brn_id = br.brn_id
group by br.brn_name
having book_count > 2;

/*Q12. Write a query to get class name whoes branch category is 'Engineering' */
select class_name from class where class_brnch_id in (select brn_id from branch where brn_ctg = 'Engineering');

/*Q13. Write a query to get Students seating in 'Class 3' */
select * from student where brnch_id in 
(select brn_id from branch where brn_id = (select class_brnch_id from class where class_name = 'Class3' ));

/*Q14. Write a query to get student details who stays in Thane */
select stu_id,stu_name,stu_ph_no,stu_email,std_addr,stu_dob from student where std_addr like 'Thane%';

/* Q15. write a query to find the highest price of book */
select book_price , book_name  from books
where book_price = (select max(book_price) highest_price from books)
