<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bank Account Portal</title>
<style>
    body {
      
        background-image: url('images/Login.jpg');
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
        text-align: center;
        color: white;
        font-family: Arial, sans-serif;
        margin-top: 150px;
    }

    .card {
        background: rgba(0, 0, 0, 0.5); 
        display: inline-block;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.4);
    }

    h1 {
        font-size: 32px;
        text-shadow: 2px 2px 6px black;
        margin-bottom: 20px;
    }

    .btn {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #6a11cb;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-size: 16px;
    }

    .btn:hover {
        background-color: #2575fc;
    }
</style>
</head>
<body>
    <div class="card">
        <h1>Premier Capital Bank</h1>
        <p>Welcome to your secure online banking portal.</p>
        <a href="BankLoginForm.jsp" class="btn">Login</a>
    </div>
</body>
</html>
