# BankEase — Online Banking Portal

A Java EE web application that allows bank customers to securely log in, view their account balance, and browse their transaction history.

---

## Project Overview

BankEase is a simple, session-based online banking portal built with **Java Servlets**, **JSP**, and **MySQL**. It authenticates customers using their account number and password, then presents their balance and recent transactions through a clean, card-style UI.

---

## Features

- **Secure Login** — Authenticates customers against a MySQL database using account number and password.
- **Session Management** — Uses `HttpSession` to maintain the logged-in state and protect pages from unauthorized access.
- **Account Balance View** — Displays the customer's name, account number, and current balance with a colour-coded health indicator:
  - 🔴 Red — Below minimum balance (< ₹1,000)
  - 🟠 Orange — Near minimum balance (₹1,000–₹1,500)
  - 🟢 Green — Healthy balance (> ₹1,500)
- **Transaction History** — Lists all past transactions (ID, date, amount, type) in a styled table fetched live from the database.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | JSP, HTML, CSS |
| Backend | Java Servlet (Jakarta EE) |
| Database | MySQL 8.x |
| JDBC Driver | `com.mysql.jdbc.Driver` |
| Server | Apache Tomcat (Jakarta EE compatible) |

---

## Project Structure

```
BankEase/
├── Login.jsp               # Landing/welcome page
├── BankLoginForm.jsp        # Login form page
├── LoginServlet.java        # Authentication servlet
├── Balance.jsp              # Account balance dashboard (session-protected)
├── TransactionHistory.jsp   # Transaction history table (session-protected)
└── images/
    └── Login.jpg            # Background image for the landing page
```

---

## Database Setup

Create a MySQL database named `project` and add the following tables.

### `accounts` table

```sql
CREATE TABLE accounts (
    account_number INT PRIMARY KEY,
    customer_name  VARCHAR(100) NOT NULL,
    password       VARCHAR(100) NOT NULL,
    balance        DOUBLE NOT NULL
);
```

### `transactions` table

```sql
CREATE TABLE transactions (
    txn_id         INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT NOT NULL,
    txn_date       DATE NOT NULL,
    amount         DOUBLE NOT NULL,
    type           VARCHAR(20) NOT NULL,
    FOREIGN KEY (account_number) REFERENCES accounts(account_number)
);
```

### Sample Data

```sql
INSERT INTO accounts VALUES (100001, 'Pooja Sharma', 'pass123', 2500.00);

INSERT INTO transactions (account_number, txn_date, amount, type) VALUES
(100001, '2025-04-01', 5000.00, 'Credit'),
(100001, '2025-04-10', 1500.00, 'Debit'),
(100001, '2025-05-01', 2000.00, 'Credit');
```

---

## Configuration

The JDBC connection is hardcoded in `LoginServlet.java` and `TransactionHistory.jsp`. Update the credentials to match your environment:

```java
String jdbcURL = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
Connection con = DriverManager.getConnection(jdbcURL, "root", "hello");
```

> ⚠️ For production use, move credentials to a context resource (e.g., `context.xml`) or environment variables and use a connection pool.

---

## How to Run

1. **Set up the database** using the SQL scripts above.
2. **Deploy to Apache Tomcat** — place the project folder in Tomcat's `webapps/` directory.
3. **Add the MySQL JDBC driver** JAR (`mysql-connector-j-*.jar`) to `WEB-INF/lib/`.
4. **Start Tomcat** and open `http://localhost:8080/<project-name>/Login.jsp` in a browser.
5. **Log in** with a valid account number and password from the `accounts` table.

---

## Page Flow

```
Login.jsp
    └── BankLoginForm.jsp  (login form)
            └── LoginServlet  (POST — validates credentials)
                    ├── Balance.jsp          (on success)
                    │       └── TransactionHistory.jsp
                    └── BankLoginForm.jsp    (on failure — shows error)
```

---

## Known Issues & Improvements

| Issue | Recommendation |
|---|---|
| Plaintext passwords stored in DB | Hash passwords with BCrypt |
| Hardcoded DB credentials | Use environment variables or Tomcat JNDI datasource |
| DB logic inside JSP (`TransactionHistory.jsp`) | Move to a Servlet or DAO layer |
| Deprecated JDBC driver class | Replace `com.mysql.jdbc.Driver` with `com.mysql.cj.jdbc.Driver` |
| Hardcoded local image path in `BankLoginForm.jsp` | Use a relative web path (e.g., `images/logo.png`) |
| No logout functionality | Add a logout servlet that invalidates the session |

---

## License

This project is intended for educational purposes.
