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

## Prerequisites

Make sure the following are installed and configured on your machine before running the project.

| Requirement | Version | Notes |
|---|---|---|
| Java JDK | 11 or higher | Set `JAVA_HOME` environment variable |
| Apache Tomcat | 10.x or higher | Must support Jakarta EE (`jakarta.servlet.*`) |
| MySQL Server | 8.x | Running on `localhost:3306` |
| MySQL Connector/J | 8.x | JDBC driver JAR for the project |
| IDE (optional) | Eclipse / IntelliJ IDEA | Eclipse IDE for Enterprise Java Developers recommended |

> ⚠️ Tomcat 9 and below use the `javax.servlet.*` namespace. This project uses `jakarta.servlet.*`, so **Tomcat 10+** is required.

---

## Configuration

The JDBC connection is hardcoded in `LoginServlet.java` and `TransactionHistory.jsp`. Update the credentials to match your environment before deploying:

```java
String jdbcURL = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
Connection con = DriverManager.getConnection(jdbcURL, "root", "hello");
```

> ⚠️ For production use, move credentials to a context resource (e.g., `context.xml`) or environment variables and use a connection pool.

---

## How to Run

### Step 1 — Set up the database

1. Start your MySQL server.
2. Open MySQL Workbench, DBeaver, or the MySQL CLI.
3. Run the following to create the database:
   ```sql
   CREATE DATABASE project;
   USE project;
   ```
4. Paste and execute the table creation and sample data SQL from the [Database Setup](#database-setup) section above.

### Step 2 — Configure the project

1. Open `LoginServlet.java` and `TransactionHistory.jsp`.
2. Update the JDBC URL, username, and password to match your local MySQL setup.
3. Place the `mysql-connector-j-*.jar` file inside `WEB-INF/lib/`. Download it from [MySQL Downloads](https://dev.mysql.com/downloads/connector/j/) if you don't have it.

### Step 3 — Deploy to Tomcat

**Option A — Using an IDE (Eclipse)**

1. Open Eclipse and go to **File → Import → Existing Projects into Workspace**.
2. Select the project folder and click **Finish**.
3. Right-click the project → **Run As → Run on Server**.
4. Select your Tomcat 10+ server instance and click **Finish**.

**Option B — Manual deployment**

1. Build the project into a `.war` file (via your IDE or `javac` + manual packaging).
2. Copy the `.war` file (or the project folder) into Tomcat's `webapps/` directory.
3. Start Tomcat:
   ```bash
   # Linux / macOS
   $CATALINA_HOME/bin/startup.sh

   # Windows
   %CATALINA_HOME%\bin\startup.bat
   ```

### Step 4 — Open in browser

Navigate to:
```
http://localhost:8080/BankEase/Login.jsp
```
Replace `BankEase` with the actual deployed folder/WAR name if different.

---

## Usage

### 1. Landing Page
Open the app URL in your browser. You will see the **Premier Capital Bank** welcome screen with a **Login** button.

### 2. Logging In
Click **Login** to go to the login form. Enter:
- **Account Number** — the integer account number (e.g., `100001`)
- **Password** — the account password (e.g., `pass123`)

Click **Submit**. If the credentials are incorrect, the login page reloads with an error message: `Invalid Account or Password`.

### 3. Account Balance Dashboard
On successful login, you are redirected to the **Balance** page, which shows:
- Your name and account number
- Your current balance in ₹
- A colour-coded status message indicating whether your balance is healthy, near the minimum, or below the minimum

### 4. Transaction History
Click the **View Transactions** button on the balance page to see a full table of your past transactions, including transaction ID, date, amount, and type (Credit/Debit).

### 5. Session Protection
All pages after login are session-protected. If you try to access `Balance.jsp` or `TransactionHistory.jsp` directly without logging in, you will be automatically redirected to the login form.

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
