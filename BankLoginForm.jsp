<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BankEase - online account access</title>
<style>
.center {
   display: block;
   margin-left: auto;
   margin-right: auto;
   width: 20%;
}
</style>
</head>
<body>
<form>
   <img src="C:\Users\Pooja\Downloads\java_logo.png" class="center" alt="Bank Logo">
   <h1><center>BankEase - online account access</center></h1>
   <input type="button" value="Login" onClick="redirectToLogin()" class="center">
   <script>
   function redirectToLogin() {
       window.location.href = "BankLoginForm.jsp";
   }
   </script>
</form>
</body>
</html>
