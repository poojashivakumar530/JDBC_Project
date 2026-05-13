import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String accno = request.getParameter("accno");
        String pass = request.getParameter("pass");

        try {
            // MySQL 8.x driver
        	Class.forName("com.mysql.jdbc.Driver");

        	String jdbcURL = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        	Connection con = DriverManager.getConnection(jdbcURL, "root", "hello");


            PreparedStatement ps = con.prepareStatement(
                    "SELECT customer_name, balance FROM accounts WHERE account_number=? AND password=?");
            ps.setInt(1, Integer.parseInt(accno));
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("accno", accno);
                session.setAttribute("custName", rs.getString("customer_name"));
                session.setAttribute("balance", rs.getDouble("balance"));
                response.sendRedirect("Balance.jsp");
            } else {
                request.setAttribute("msg", "Invalid Account or Password");
                RequestDispatcher rd = request.getRequestDispatcher("BankLoginForm.jsp");
                rd.forward(request, response);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
