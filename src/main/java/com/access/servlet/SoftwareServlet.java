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
import jakarta.servlet.http.HttpSession;

@WebServlet("/SoftwareServlet")
public class SoftwareServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/users";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "W7301@jqir#";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get session and check if user is Admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equals("Admin")) {
            response.sendRedirect("login.jsp?error=Unauthorized+Access");
            return;
        }

        // Retrieve form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] accessLevels = request.getParameterValues("accessLevel");

        // Combine access levels into a comma-separated string (e.g., "Read,Write,Admin")
        String accessLevelsStr = String.join(",", accessLevels);

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to insert new software
            String sql = "INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setString(3, accessLevelsStr);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Redirect to a success page or back to the software creation page with a success message
                response.sendRedirect("createSoftware.jsp?success=Software+added+successfully");
            } else {
                response.sendRedirect("createSoftware.jsp?error=Failed+to+add+software");
            }

            // Clean up resources
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("createSoftware.jsp?error=Database+error");
        }
    }
}
