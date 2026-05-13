<%@ page import="java.sql.*,jakarta.servlet.http.*" %>
<%
   if(session == null || session.getAttribute("accno") == null){ 
       response.sendRedirect("BankLoginForm.jsp"); 
   } else { 
       String accno = (String) session.getAttribute("accno"); 
       try { 
           Class.forName("com.mysql.jdbc.Driver"); 
           Connection con = DriverManager.getConnection(
             "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
             "root","hello"); 
           PreparedStatement ps = con.prepareStatement( 
               "SELECT txn_id, txn_date, amount, type FROM transactions WHERE account_number=?"); 
           ps.setInt(1, Integer.parseInt(accno)); 
           ResultSet rs = ps.executeQuery(); 
%>
<html>
<head>
<title>Transaction History</title>
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
        width: 600px;
        text-align: center;
    }
    h2 { color: #333; margin-bottom: 20px; }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 10px;
    }
    th {
        background: #6a11cb;
        color: white;
    }
    tr:nth-child(even) {
        background: #f9f9f9;
    }
</style>
</head>
<body>
    <div class="card">
        <h2>Transaction History</h2>
        <table>
            <tr><th>ID</th><th>Date</th><th>Amount</th><th>Type</th></tr>
            <% while(rs.next()){ %>
                <tr>
                    <td><%= rs.getInt("txn_id") %></td>
                    <td><%= rs.getDate("txn_date") %></td>
                    <td><%= rs.getDouble("amount") %></td>
                    <td><%= rs.getString("type") %></td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
<%
           con.close(); 
       } catch(Exception e){ out.println(e); } 
   } 
%>
