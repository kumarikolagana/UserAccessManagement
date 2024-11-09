package com.access.servlet;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/users";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "W7301@jqir#";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate credentials
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to validate credentials
            String sql = "SELECT id, role FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Credentials are valid, retrieve user info
                int userId = rs.getInt("id");
                String role = rs.getString("role");

                // Create a new session for the user
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Redirect based on user role
                if (role.equals("Employee")) {
                    response.sendRedirect("requestAccess.jsp");
                } else if (role.equals("Manager")) {
                    response.sendRedirect("pendingRequests.jsp");
                } else if (role.equals("Admin")) {
                    response.sendRedirect("createSoftware.jsp");
                }
            } else {
                // Invalid credentials, redirect to login page with an error message
                response.sendRedirect("login.jsp?error=Invalid+username+or+password");
            }

            // Clean up resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Login+error");
        }
    }
}
