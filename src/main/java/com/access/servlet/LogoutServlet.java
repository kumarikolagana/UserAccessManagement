package com.access.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session, if it exists
        HttpSession session = request.getSession(false);
        
        // If a session exists, invalidate it to log the user out
        if (session != null) {
            session.invalidate();
        }

        // Redirect to the login page (or a logout confirmation page if preferred)
        response.sendRedirect("login.jsp?message=Successfully+logged+out");
    }
}
