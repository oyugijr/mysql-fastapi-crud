# 📇 Contact Book CRUD API

A FastAPI-based CRUD API that manages a contact book backed by a MySQL database.

---

## 🚀 Features

- 📦 Create, Read, Update, and Delete contacts
- 🔐 Uses environment variables for configuration
- 🧱 Built with SQLAlchemy ORM
- 🧪 Lightweight and easy to run

---

## 🛠️ Tech Stack

- **Backend**: FastAPI
- **Database**: MySQL
- **ORM**: SQLAlchemy
- **Environment**: `.env` using `python-dotenv`

---

## 🏗️ Database Schema

### Table: `contacts`

| Column      | Type         | Constraints             |
|-------------|--------------|--------------------------|
| contact_id  | INT          | Primary Key, Auto-Increment |
| name        | VARCHAR(100) | NOT NULL                |
| email       | VARCHAR(100) | UNIQUE, NOT NULL        |
| phone       | VARCHAR(20)  | NULLABLE                |
| created_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP |

📎 ERD Screenshot:
![ERD](A_diagram_of_an_Entity-Relationship_Diagram_(ERD)_.png)

---

## 🧩 Setup Instructions

### 📂 Clone the Repository

```bash
git clone https://github.com/yourusername/mysql-db-fastapi-crud.git
cd mysql-db-fastapi-crud/contact-api
