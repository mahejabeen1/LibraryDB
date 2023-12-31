Create Table books (Book_id INT,Title varchar(200),Author_id INT,ISBN varchar(20),Genre varchar(50),Published_year INT,Available_copies INT);
ALTER TABLE books ADD CONSTRAINT pkbook_id primary key(book_id);
Create table authors (author_id int, constraint pkauthor_id primary key (author_id), firstname varchar(50), lastname varchar(50), birthdate date, nationality varchar(50));
ALTER TABLE books ADD CONSTRAINT fk_authorid FOREIGN KEY (author_id) REFERENCES authors(author_id);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(200),
    Email VARCHAR(100)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    MemberID INT,
    book_id INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

--AvailableBooks View
CREATE VIEW AvailableBooks AS
SELECT * FROM Books WHERE available_copies > 0;


--BorrowedBooksView View
CREATE VIEW BorrowedBooksView AS
SELECT Members.FirstName, Members.LastName, Books.Title, Transactions.BorrowDate, Transactions.ReturnDate
FROM Transactions
JOIN Members ON Transactions.MemberID = Members.MemberID
JOIN Books ON Transactions.book_id = Books.book_id;
