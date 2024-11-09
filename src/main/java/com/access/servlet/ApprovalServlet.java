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

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/users";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "W7301@jqir#";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is a Manager
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equals("Manager")) {
            response.sendRedirect("login.jsp?error=Unauthorized+Access");
            return;
        }

        // Get the action parameter and determine approval/rejection
        String action = request.getParameter("action");
        if (action == null || (!action.startsWith("approve_") && !action.startsWith("reject_"))) {
            response.sendRedirect("pendingRequests.jsp?error=Invalid+Action");
            return;
        }

        // Parse the request ID and determine the new status
        int requestId = Integer.parseInt(action.split("_")[1]);
        String newStatus = action.startsWith("approve_") ? "Approved" : "Rejected";

        try {
            // Update the status of the request in the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newStatus);
            stmt.setInt(2, requestId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("pendingRequests.jsp?success=Request+updated+successfully");
            } else {
                response.sendRedirect("pendingRequests.jsp?error=Failed+to+update+request");
            }

            // Clean up resources
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("pendingRequests.jsp?error=Database+error");
        }
    }
}
