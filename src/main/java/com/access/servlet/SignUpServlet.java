package com.access.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/users";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "W7301@jqir#";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = "Employee";  // Default role

        // Validate that required fields are provided
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("signup.jsp?error=Missing+required+fields");
            return;
        }

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to insert a new user
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, role);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Redirect to login page on successful registration
                response.sendRedirect("login.jsp");
            } else {
                
                response.sendRedirect("signup.jsp?error=Failed+to+register");
            }

            // Clean up resources
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=Registration+error");
        }
    }
}
