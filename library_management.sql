-- LIBRARY MANAGEMENT SYSTEM SCHEMA AND DATA

-- Drop existing tables for clean setup
DROP TABLE IF EXISTS BookLoans, Payments, Books, Members, Librarians, Categories;

-- Table: Categories
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Books (1-M with Categories)
CREATE TABLE Books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    copies_available INT NOT NULL DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES Categories(id)
);

-- Table: Members
CREATE TABLE Members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    membership_date DATE NOT NULL
);

-- Table: Librarians
CREATE TABLE Librarians (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Table: BookLoans (many-to-many relationship resolver between Books and Members)
CREATE TABLE BookLoans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    librarian_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Borrowed', 'Returned', 'Overdue') DEFAULT 'Borrowed',
    FOREIGN KEY (book_id) REFERENCES Books(id),
    FOREIGN KEY (member_id) REFERENCES Members(id),
    FOREIGN KEY (librarian_id) REFERENCES Librarians(id)
);

-- Table: Payments (1-M with BookLoans)
CREATE TABLE Payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(8, 2) NOT NULL,
    payment_date DATE NOT NULL,
    method ENUM('Cash', 'Card') NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES BookLoans(id)
);

-- Insert Sample Data

-- Categories
INSERT INTO Categories (name) VALUES ('Fiction'), ('Science'), ('History');

-- Books
INSERT INTO Books (title, author, category_id, isbn, copies_available) VALUES
('1984', 'George Orwell', 1, '9780451524935', 3),
('A Brief History of Time', 'Stephen Hawking', 2, '9780553380163', 2),
('Sapiens', 'Yuval Noah Harari', 3, '9780099590088', 4);

-- Members
INSERT INTO Members (name, email, phone, membership_date) VALUES
('Alice Walker', 'alice@example.com', '0700111222', '2024-01-15'),
('Bob Stone', 'bob@example.com', '0700333444', '2024-03-10');

-- Librarians
INSERT INTO Librarians (name, email) VALUES
('Jane Doe', 'jane@library.com'),
('John Smith', 'john@library.com');

-- Book Loans
INSERT INTO BookLoans (book_id, member_id, librarian_id, loan_date, due_date, status) VALUES
(1, 1, 1, '2025-04-28', '2025-05-05', 'Borrowed'),
(2, 2, 2, '2025-04-20', '2025-04-27', 'Returned');

-- Payments
INSERT INTO Payments (loan_id, amount, payment_date, method) VALUES
(2, 100.00, '2025-04-27', 'Cash');

-- ========================================
-- EXPLANATION: WHAT ARE JOINS AND WHY USE THEM?
-- ========================================
-- JOINS allow you to combine rows from two or more tables based on related columns (usually foreign keys).
-- They're essential to get meaningful information across multiple tables.

-- Examples:

-- 1. All currently borrowed books with member info
SELECT b.title, m.name AS borrower, bl.loan_date, bl.due_date
FROM BookLoans bl
JOIN Books b ON bl.book_id = b.id
JOIN Members m ON bl.member_id = m.id
WHERE bl.status = 'Borrowed';

-- 2. Count books per category
SELECT c.name AS category, COUNT(b.id) AS total_books
FROM Categories c
LEFT JOIN Books b ON c.id = b.category_id
GROUP BY c.name;

-- 3. Member loan history
SELECT m.name, b.title, bl.loan_date, bl.return_date
FROM Members m
JOIN BookLoans bl ON m.id = bl.member_id
JOIN Books b ON bl.book_id = b.id
WHERE m.id = 1;

-- 4. Total fines collected by each librarian
SELECT l.name, SUM(p.amount) AS total_collected
FROM Librarians l
JOIN BookLoans bl ON l.id = bl.librarian_id
JOIN Payments p ON bl.id = p.loan_id
GROUP BY l.name;

-- ========================================
-- EXPLANATION: WHAT IS A VIEW AND WHY USE IT?
-- ========================================
-- A VIEW is a virtual table based on a query result.
-- It helps simplify complex queries and improves reusability and readability.
-- Views are useful for:
-- - Presenting data in a specific format
-- - Abstracting joins
-- - Enhancing security by exposing only necessary columns

-- View: Returned Book Loans

CREATE VIEW ReturnedBooks AS
SELECT bl.id, b.title, m.name AS member, bl.return_date
FROM BookLoans bl
JOIN Books b ON bl.book_id = b.id
JOIN Members m ON bl.member_id = m.id
WHERE bl.status = 'Returned';
