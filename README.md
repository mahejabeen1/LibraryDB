# Library Database
## Overview
This library database is designed to manage information about books, authors, borrowers, and transactions in a library setting. It includes tables for authors, books, publishers, members (borrowers), and transactions. The structure is designed to provide flexibility and scalability for a comprehensive library management system.

## Tables
Authors: Contains information about authors.
Books: Stores details about each book, including title, author, ISBN, and availability.
Publishers: Manages data related to book publishers.
Members: Stores details about library members (borrowers).
Transactions: Tracks borrowing and returning of books by members.

## Usage Queries

### Retrieve all books
SELECT * FROM Books;

### Retrieve Available Books
SELECT * FROM Books WHERE available_copies > 0;

### Search Books by Title or Author
SELECT * FROM Books
WHERE Title LIKE '%search_term%' OR
      EXISTS (SELECT 1 FROM Authors WHERE Books.author_id = Authors.author_id AND (FirstName LIKE '%search_term%' OR LastName LIKE '%search_term%'));

### List Borrowed Books and Due Dates
SELECT Members.FirstName, Members.LastName, Books.Title, Transactions.BorrowDate, Transactions.ReturnDate
FROM Transactions
JOIN Members ON Transactions.MemberID = Members.MemberID
JOIN Books ON Transactions.book_id = Books.book_id
WHERE Transactions.ReturnDate IS NULL;

### Top Borrowed Books
SELECT Books.Title, COUNT(*) AS BorrowCount
FROM Transactions
JOIN Books ON Transactions.book_id = Books.book_id
GROUP BY Books.Title
ORDER BY BorrowCount DESC
LIMIT 5;

### AvailableBooks View
CREATE VIEW AvailableBooks AS
SELECT * FROM Books WHERE available_copies > 0;

### BorrowedBooksView View
CREATE VIEW BorrowedBooksView AS
SELECT Members.FirstName, Members.LastName, Books.Title, Transactions.BorrowDate, Transactions.ReturnDate
FROM Transactions
JOIN Members ON Transactions.MemberID = Members.MemberID
JOIN Books ON Transactions.book_id = Books.book_id;

### Updating Data
To update data in the database, use standard SQL UPDATE, INSERT, and DELETE statements. For example:

###  Update book information
UPDATE Books SET available_copies = 15 WHERE BookID = 1;

###  Insert a new member
INSERT INTO Members (MemberID, FirstName, LastName, Address, Email)
VALUES (10, 'New', 'Member', '123 Street, City', 'new@email.com');

INSERT INTO Authors (Author_ID, FirstName, LastName, BirthDate, Nationality)
VALUES
    (1, 'Alice', 'Peterson', '1980-05-15', 'American'),
    (2, 'James', 'Smith', '1975-10-20', 'British'),
    (3, 'Sherry', 'Johnson', '1990-03-08', 'Canadian');
    (4, 'Robert', 'Brown', '1985-08-22', 'American'),
    (5, 'Sophie', 'Wong', '1995-04-12', 'Chinese');

INSERT INTO Publishers (PublisherID, PublisherName, Address, Phone)
VALUES
    (1, 'Solar Publishers', '123 Main St, Cityville', '123-456-7890'),
    (2, 'Galaxy Publications', '456 Oak St, Townsville', '987-654-3210');
    (3, 'LMN Books', '789 Cedar St, Villagetown', '456-789-0123'),
    (4, 'PQR Press', '567 Maple St, Cityburg', '789-012-3456');

INSERT INTO Books (Book_ID, Title, Author_ID, ISBN, Genre, Published_Year, Available_copies)
VALUES
    (1, 'The Secret Symphony', 1, '978-1-234567-89-0', 'Fiction', 1911, 5),
    (2, 'The Da Vinci Code', 2, '978-0-765-37374-9', 'Mystery', 2003, 8),
    (3, 'V for Vendetta', 3, '978-0-441-17271-9', 'Science Fiction', 1965, 3);
    (4, 'The Great Gatsby', 4, '978-0-7432-7356-5', 'Historical Fiction', 1925, 10),
    (5, 'Gone Girl', 5, '978-0-307-58836-4', 'Thriller', 2012, 6),
    (6, 'To Kill a Mockingbird', 4, '978-0-06-112008-4', 'Historical Fiction', 1960, 7);

INSERT INTO Members (MemberID, FirstName, LastName, Address, Email)
VALUES
    (1, 'Michael', 'Johnson', '789 Elm St, Villagetown', 'michael@email.com'),
    (2, 'Emily', 'Davis', '456 Pine St, Cityburg', 'emily@email.com'),
    (3, 'Chris', 'Miller', '101 Oak St, Townsville', 'chris@email.com');
    (4, 'Amanda', 'Taylor', '876 Birch St, Cityville', 'amanda@email.com'),
    (5, 'Daniel', 'Nguyen', '234 Oak St, Townsville', 'daniel@email.com');

INSERT INTO Transactions (TransactionID, MemberID, Book_ID, BorrowDate, ReturnDate)
VALUES
    (1, 1, 1, '2023-01-10', '2023-01-25'),
    (2, 2, 2, '2023-02-05', '2023-02-20'),
    (3, 3, 3, '2023-03-15', NULL);
    (4, 4, 4, '2023-04-01', '2023-04-15'),
    (5, 5, 5, '2023-05-10', '2023-05-25'),
    (6, 4, 6, '2023-06-15', NULL);

###  Delete a transaction
DELETE FROM Transactions WHERE TransactionID = 3;


###  creating view to know how many females are there

create or replace view femalecustomers as
select * from customer1 where customergender = 'F';




sql dvd challenges

1] alter table film
add column has_specialfeature int;

1]
create table film1 (film_id serial primary key,title varchar(255),special_features text);
insert into film1(film_id,title,special_features) values (1,'academy dinosaur','a'),(2,'ace goldfinger','b'),(3,'adaptation holes','c');

alter table film1
add column has_special_feature int;

update film1
set has_special_feature = case when special_features <> 'A' then 1 else 0 end;

insert into film1(film_id, title,special_features) values(4, 'Agent truman',2);



update film1 set has_special_feature = case when special_features <> 'A' then 1 else 0 end;



SELECT
    film_id,
    title,
    special_features,
    ###  Create dummy variables for each kind of special feature
    CASE WHEN 'Trailers' = ANY (string_to_array(special_features, ',')) THEN 1 ELSE 0 END AS Trailers,
    CASE WHEN 'Commentaries' = ANY (string_to_array(special_features, ',')) THEN 1 ELSE 0 END AS Commentaries,
    CASE WHEN 'Deleted Scenes' = ANY (string_to_array(special_features, ',')) THEN 1 ELSE 0 END AS Deleted_Scenes,
    CASE WHEN 'Behind the Scenes' = ANY (string_to_array(special_features, ',')) THEN 1 ELSE 0 END AS Behind_the_Scenes
FROM film;










2]SELECT c.name AS category_name, COUNT(r.rental_id) AS rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY rental_count DESC;



SELECT name, COUNT(*) 
FROM category , film_category , inventory , rental 
WHERE category.category_id=film_category.category_id
AND film_category.film_id=inventory.film_id
AND inventory.inventory_id=rental.inventory_id
Group By category.name
Order by count(*) Desc;
compare this to below

SELECT c.name as category_name, COUNT(*) as rental_count 
FROM category c , film_category fc , inventory i , rental r
WHERE c.category_id=fc.category_id
AND fc.film_id=i.film_id
AND i.inventory_id=r.inventory_id
Group By c.name
Order by rental_count Desc;