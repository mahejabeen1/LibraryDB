Library Database
Overview
This library database is designed to manage information about books, authors, borrowers, and transactions in a library setting. It includes tables for authors, books, publishers, members (borrowers), and transactions. The structure is designed to provide flexibility and scalability for a comprehensive library management system.

Tables
Authors: Contains information about authors.
Books: Stores details about each book, including title, author, ISBN, and availability.
Publishers: Manages data related to book publishers.
Members: Stores details about library members (borrowers).
Transactions: Tracks borrowing and returning of books by members.

Usage
Queries
--Retrieve all books
SELECT * FROM Books;

--Retrieve Available Books
SELECT * FROM Books WHERE available_copies > 0;


--Search Books by Title or Author
SELECT * FROM Books
WHERE Title LIKE '%search_term%' OR
      EXISTS (SELECT 1 FROM Authors WHERE Books.author_id = Authors.author_id AND (FirstName LIKE '%search_term%' OR LastName LIKE '%search_term%'));

--List Borrowed Books and Due Dates
SELECT Members.FirstName, Members.LastName, Books.Title, Transactions.BorrowDate, Transactions.ReturnDate
FROM Transactions
JOIN Members ON Transactions.MemberID = Members.MemberID
JOIN Books ON Transactions.book_id = Books.book_id
WHERE Transactions.ReturnDate IS NULL;

--Top Borrowed Books
SELECT Books.Title, COUNT(*) AS BorrowCount
FROM Transactions
JOIN Books ON Transactions.book_id = Books.book_id
GROUP BY Books.Title
ORDER BY BorrowCount DESC
LIMIT 5;

--AvailableBooks View
CREATE VIEW AvailableBooks AS
SELECT * FROM Books WHERE available_copies > 0;

--BorrowedBooksView View
CREATE VIEW BorrowedBooksView AS
SELECT Members.FirstName, Members.LastName, Books.Title, Transactions.BorrowDate, Transactions.ReturnDate
FROM Transactions
JOIN Members ON Transactions.MemberID = Members.MemberID
JOIN Books ON Transactions.book_id = Books.book_id;

Updating Data
To update data in the database, use standard SQL UPDATE, INSERT, and DELETE statements. For example:

-- Update book information
UPDATE Books SET available_copies = 15 WHERE BookID = 1;

-- Insert a new member
INSERT INTO Members (MemberID, FirstName, LastName, Address, Email)
VALUES (10, 'New', 'Member', '123 Street, City', 'new@email.com');

-- Delete a transaction
DELETE FROM Transactions WHERE TransactionID = 3;
