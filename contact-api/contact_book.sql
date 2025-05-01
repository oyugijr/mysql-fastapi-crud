-- Contact Book Schema
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data
INSERT INTO contacts (name, email, phone) VALUES
('Oyugi Mourice', 'oyugimaurice22@gmail.com', '0700314150'),
('Alice Mwangi', 'alice@example.com', '0712345678'),
('Brian Otieno', 'brian@example.com', '0798765432');
