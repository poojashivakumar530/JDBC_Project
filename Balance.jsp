<%@ page import="jakarta.servlet.http.*" %>
<%
   if(session == null || session.getAttribute("accno") == null){ 
       response.sendRedirect("BankLoginForm.jsp"); 
   } else { 
       String name = (String) session.getAttribute("custName"); 
       String accno = (String) session.getAttribute("accno"); 
       double balance = (Double) session.getAttribute("balance"); 
%>
<html>
<head>
<title>Account Balance</title>
<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .card {
        background: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0px 4px 15px rgba(0,0,0,0.2);
        width: 400px;
        text-align: center;
    }
    h2, h3, p {
        color: #333;
    }
    .status-red { color: red; }
    .status-orange { color: orange; }
    .status-green { color: green; }
    a {
        display: inline-block;
        margin-top: 15px;
        text-decoration: none;
        background: #6a11cb;
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        transition: 0.3s;
    }
    a:hover {
        background: #2575fc;
    }
</style>
</head>
<body>
    <div class="card">
        <h2>Welcome, <%= name %></h2>
        <h3>Account Number: <%= accno %></h3>
        <h3>Balance: Rs. <%= balance %></h3>
        <% if(balance < 1000) { %>
            <p class="status-red">Your balance is below Minimum Balance!</p>
        <% } else if(balance <= 1500) { %>
            <p class="status-orange">Warning: Your balance is near Minimum Balance.</p>
        <% } else { %>
            <p class="status-green">Balance is Healthy.</p>
        <% } %>
        <a href="TransactionHistory.jsp">View Transactions</a>
    </div>
</body>
</html>
<% } %>
