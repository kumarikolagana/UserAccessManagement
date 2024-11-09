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

@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/users";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "W7301@jqir#";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user session and ensure role is Employee
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");
        if (userId == null || !role.equals("Employee")) {
            response.sendRedirect("login.jsp?error=Unauthorized+Access");
            return;
        }

        // Retrieve form data
        int softwareId = Integer.parseInt(request.getParameter("softwareId"));
        String accessType = request.getParameter("accessType");
        String reason = request.getParameter("reason");

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to insert a new access request with status "Pending"
            String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, 'Pending')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, softwareId);
            stmt.setString(3, accessType);
            stmt.setString(4, reason);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Redirect to a success page or back to the request page with a success message
                response.sendRedirect("requestAccess.jsp?success=Request+submitted+successfully");
            } else {
                response.sendRedirect("requestAccess.jsp?error=Failed+to+submit+request");
            }

            // Clean up resources
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("requestAccess.jsp?error=Database+error");
        }
    }
}
