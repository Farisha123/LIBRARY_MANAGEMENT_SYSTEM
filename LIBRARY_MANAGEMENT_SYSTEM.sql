create database library;
use library;
create table Branch(Branch_id INT PRIMARY KEY,
Manager_id INT,
Branch_address VARCHAR(30),
CONTACT_NO VARCHAR(30));

INSERT INTO Branch(Branch_id,manager_id,branch_address,contact_no)
values(1,1001,'kottakkal','9234567321'),
(2,1002,'perinthalmanna','9634567321'),
(3,1003,'kondotty','9897567321'),
(4,1004,'manjeri','9934567354'),
(5,1005,'edappaal','8234567390'),
(6,1006,'tirur','934567321');

select * from branch;

create table Employee(Employee_id INT PRIMARY KEY,
Employee_name VARCHAR(30),
E_position VARCHAR(30),
salary decimal(7,2));

 
 
INSERT INTO employee(employee_id,employee_name,e_position,salary)
values(1001,'arjun','manager',42000.00),
(1002,'akash','clerk',22000.00),
(1003,'amrutha','sales',12000.00),
(1004,'vijay','clerk',22000.00),
(1005,'nithya','sales',12000.00),
(1006,'hari','distributor',18000.00);
 
select * from employee;

create table customer(customer_id INT PRIMARY KEY,
customer_name VARCHAR(30),
customer_address VARCHAR(30),
reg_date date);

insert into customer(customer_id,customer_name,customer_address,reg_date)
values(111,'asad','randathani','2020-01-01'),
(112,'adam','changaramchola','2023-06-01'),
(113,'farisha','machinchery','2021-03-01'),
(114,'fasna','kurukathani','2022-04-08'),
(115,'ihan','mangadan','2022-06-06'),
(116,'afnan','chungam','2019-01-01');

select * from customer;

create table books(ISBN VARCHAR(13) PRIMARY KEY,
BOOK_TITLE VARCHAR(30),
category VARCHAR(30),
RENTAL_PRICE DECIMAL(5,2),
B_STATUS VARCHAR(3),
AUTHOR VARCHAR(30),
PUBLISHER VARCHAR(30));

  
INSERT INTO BOOKS(ISBN,BOOK_TITLE,CATEGORY,RENTAL_PRICE,B_STATUS,AUTHOR,PUBLISHER) VALUES
('9087654321123','ADUJEEVITHAM','NOVAL',250.00,'YES','BENYAMIN','GREEN BOOK PVT LIMITED'),
('1287654321123','RANDAMOOYHAM','NOVAL',150.00,'YES','M.T.V','CURRENT BOOKS'),
('9456654321123','VANITY FAIR','NOVAL',200.00,'NO','William Makepeace Thackeray','CAMBRIDGE UNIVERSITY PRESS'),
('8987654321123','OTHELLO','STORY',250.00,'YES','WILLIAM SHEKSPEARE','BRITISH LIBRARY'),
('9987654321123','HAMLET','PLAY',250.00,'NO','WILLIAM SHEKSPEARE','BRITISH LIBRARY'),
('7657654321123','ENTE KADHA','AUTO BIOGRAPHYL',250.00,'YES','MADHAVIKUTTY','D C BOOKS');
SELECT * FROM BOOKS;

create table IssueStatus(Issue_id INT PRIMARY KEY,
Issue_cust INT,
FOREIGN KEY(Issue_cust) references customer(customer_id),
ISSUED_BOOK_NAME VARCHAR(30),
ISSUE_DATE DATE,
ISBN_BOOK VARCHAR(13),
FOREIGN KEY(ISBN_BOOK) REFERENCES BOOKS(ISBN));

INSERT INTO ISSUESTATUS VALUES(555,111,'ADUJEEVITHAM','2023-01-01','9087654321123'),
(556,112,'OTHELLO','2023-01-10','8987654321123'),
(557,113,'ENTEKADHA','2023-01-03','7657654321123'),
(558,114,'RANDAMOOYAM','2023-02-03','1287654321123'),
(559,115,'VANITY FAIR','2023-03-06','9456654321123'),
(600,116,'HAMLET','2023-01-03','9987654321123');

SELECT * FROM ISSUESTATUS;

create table returnStatus(return_id INT PRIMARY KEY,
return_cust INT,
return_BOOK_NAME VARCHAR(30),
return_DATE DATE,
ISBN_BOOK2 VARCHAR(13),
FOREIGN KEY(ISBN_BOOK2) REFERENCES BOOKS(ISBN));

INSERT INTO RETURNSTATUS VALUES(301,111,'ADUJEEVITHAM','2023-02-01','9087654321123'),
(302,112,'OTHELLO','2023-02-10','8987654321123'),
(303,113,'ENTEKADHA','2023-02-03','7657654321123'),
(304,114,'RANDAMOOYAM','2023-03-03','1287654321123'),
(305,115,'VANITY FAIR','2023-04-06','9456654321123'),
(306,116,'HAMLET','2023-05-03','9987654321123');

SELECT * FROM RETURNSTATUS;

#Retrieve the book title, category, and rental price of all available books.

SELECT BOOK_TITLE,CATEGORY,RENTAL_PRICE FROM BOOKS WHERE B_STATUS='YES';

# List the employee names and their respective salaries in descending ORDER OF SALARY?

SELECT EMPLOYEE_NAME,SALARY FROM EMPLOYEE ORDER BY SALARY DESC;


# Retrieve the book titles and the corresponding customers who have issued those books


 SELECT B.BOOK_TITLE,C.CUSTOMER_NAME FROM ISSUESTATUS I JOIN BOOKS B
 ON I.ISBN_BOOK=B.ISBN
 JOIN CUSTOMER C ON I.ISSUE_CUST=C.CUSTOMER_ID;
 
 #Display the total count of books in each category
 
 SELECT CATEGORY,COUNT(*) AS COUNT FROM BOOKS GROUP BY CATEGORY;
 
 # Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
 
 SELECT EMPLOYEE_NAME,E_POSITION FROM EMPLOYEE WHERE SALARY>40000.00;
 
 
# List the customer names who registered before 2022-01-01 and have not issued any books yet.

select customer_name from customer
 where reg_date<'2022-01-01' 
and customer_id not in(select issue_cust from issuestatus);

 #Display the branch numbers and the total count of employees in each branch?
 
 select branch_id,count(*)  as count from branch  group by branch_id;
 
 
#Display the names of customers who have issued books in the month of June 2023.

select customer_name from customer c join issuestatus i on 
c.customer_id=i.issue_cust
where month(i.issue_date)=06 and year(i.issue_date)=2023;

#Retrieve book_title from book table containing story.

select book_title from books where category='story';


#Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

select branch_id,count(e.e_position) as total_employees from branch b
left join employee e on b.manager_id=e.employee_id
group by b.branch_id having total_employees>5;


