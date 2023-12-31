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
