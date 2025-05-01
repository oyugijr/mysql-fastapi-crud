# 🗂️ mysql-db-fastapi-crud

This repository contains two MySQL-based projects:

1. 📚 **Library Management System** – a structured SQL database project
2. 📇 **Contact Book CRUD API** – a backend CRUD app using FastAPI + MySQL

---

## 📘 Project 1: Library Management System (SQL Only)

### 🔹 Description

A complete relational database for managing library operations, including books, members, authors, and loans.

### 🔸 Features

- Proper relational schema (1-1, 1-M, M-M)
- Use of constraints: PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE
- Sample data included for testing

### 📁 Files

- `library_management.sql`: Contains all `CREATE TABLE` statements and `INSERT` sample data

### 🗺️ ERD

📌 *[Insert link or screenshot here]*

---

## 📕 Project 2: Contact Book CRUD API (FastAPI + MySQL)

### 🔹 Description

A simple REST API to manage a list of contacts with full CRUD functionality.

### 🔸 Tech Stack

- **Backend**: FastAPI
- **Database**: MySQL
- **ORM**: SQLAlchemy

### 🧱 Database Schema

Includes a single `contacts` table with fields:

- `contact_id`, `name`, `email`, `phone`, `created_at`

### 🚀 How to Run

1. Clone the repo

   ```bash
   git clone https://github.com/yourusername/mysql-db-fastapi-crud.git
   cd mysql-db-fastapi-crud/contact-api
   ```
