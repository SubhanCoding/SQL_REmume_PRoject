create database project;
use project;

-- Import the data first


-- Basic Queries
-- 1) Retrieve all books in the "Fiction" genre

Select * from books where genre ='Fiction';

-- 2) Find books published after the year 1950

Select * from books where Published_Year > 1950;

-- 3) List all customers from the Canada

Select * from customers where Country = 'Canada';

-- 4) Show orders placed in November 2023

select * from orders where order_date between '2023-11-01' and '2023-11-30';

select* from orders where month(order_date)=11 and year(order_date)=2023;

-- 5) Retrieve the total stock of books available

select sum(stock) from books;

-- 6) Find the details of the most expensive book

select * from books order by Price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book

select * from orders where Quantity >1;

-- 8) Retrieve all orders where the total amount exceeds $20

select * from orders where Total_Amount > 20;

-- 9) List all genres available in the Books table

select distinct genre from books;

-- 10) Find the book with the lowest stock

select * from books order by stock asc  limit 9 offset 5; 

-- 11) Calculate the total revenue generated from all orders

select sum(Total_Amount) as TR from orders ;

-- Advance Queries
-- 1) Retrieve the total number of books sold for each genre

select  books.Genre,sum(orders.Quantity )as TBS
from orders join books on
books.Book_ID = orders.Book_ID group by Genre ;

-- 2) Find the average price of books in the "Fantasy" genre

select round(sum(AVGAmount),2),Genre from
(select avg(Total_Amount)  as AVGAmount,  books.Genre 
from books join orders on
books.Book_ID = orders.Book_ID group by Genre )
 as tA
where Genre='Fantasy';


select round(avg(Price),2) as AP from books where Genre ='Fantasy';

-- 3) List customers who have placed at least 2 orders

select Customer_ID , count(Order_ID) as Total_Order 
FROM orders
group by Customer_ID
having Total_Order>=2;

-- 4) Find the most frequently ordered book

select b.Title, o.Book_ID ,sum(o.Quantity)as TQ from 
orders o join books b on
o.Book_ID =b.Book_ID
group by o.Book_ID,b.Title
order by TQ desc;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre 

Select Title, Genre,Price  from books
where Genre ='Fantasy'
order by price Desc
limit 3;

-- 6) Retrieve the total quantity of books sold by each author

select b.Author,sum(o.Quantity) as QOBSBA
from books b join orders o on
b.Book_ID = o.Book_ID
group by b.author
order by sum(o.Quantity) desc;

-- 7) List the cities where customers who spent over $30 are located

Select distinct c.City,o.Total_Amount from orders o 
join customers c  on
o.Customer_iD -c.Customer_ID
where o.Total_Amount >30;


-- 8) Find the customer who spent the most on orders

select c.Name ,o.Customer_ID,count(o.Order_Id)as NO_of_ORders, 
Round(sum(o.Total_Amount),1)as Most_spend
from orders o join customers c on 
c.CUstomer_ID = o.Customer_ID
group by c.Customer_ID,c.Name
order by Most_spend desc
limit 1;

-- 9) Calculate the stock remaining after fulfilling all order

select b.Book_ID,b.Title,b.stock, coalesce(sum(o.Quantity),0)as Order_Quantity,
b.stock- coalesce(sum(o.Quantity),0)as remaining_stock
from books b left join orders o on
b.Book_ID =o.Book_ID 
group by b.Book_ID,b.Title,b.stock;


----------------------------------------------------------------------------------------------

