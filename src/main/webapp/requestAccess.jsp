<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    // Check if the user is an Employee; otherwise, redirect to login page
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Employee")) {
        response.sendRedirect("login.jsp?error=Access+Denied");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
   <!--    <style>
        /* Center content on the page */
        body, html {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: left;
        }
        img {
            width: 100px;
            height: auto;
            margin-bottom: 20px;
        }
        button {
            margin-top: 20px;
        }
    </style>--> 
    
    
    
    
     <style>
        /* General styles */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        /* Container styling */
        .container {
            width: 100%;
            max-width: 800px;
            padding: 20px;
        }

        /* Header styling */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 2px solid #333;
            margin-bottom: 20px;
        }

        .header h1 {
            margin: 0;
        }

        .logout-btn {
            padding: 8px 12px;
            background-color: #ff4d4d;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        
        /* Form styling */
        form label {
            font-weight: bold;
        }

        button {
            margin-top: 20px;
        }
    </style>
    
    
    
</head>
<body>

<div class="container">
    <!-- Header with User Management title and Logout button -->
    <div class="header">
        <h1>User Management</h1>
        <form action="LogoutServlet" method="get">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>

    <h2>Request Access to Software</h2>
    <form action="RequestServlet" method="post">
        <label for="software">Software Name:</label>
        <select id="software" name="softwareId" required>
            <%
                // Load software options from the database
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/users", "root", "W7301@jqir#");
                    String sql = "SELECT id, name FROM software";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        int softwareId = rs.getInt("id");
                        String softwareName = rs.getString("name");
            %>
                        <option value="<%= softwareId %>"><%= softwareName %></option>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select><br><br>

        <label for="accessType">Access Type:</label>
        <select id="accessType" name="accessType" required>
            <option value="Read">Read</option>
            <option value="Write">Write</option>
            <option value="Admin">Admin</option>
        </select><br><br>

        <label for="reason">Reason for Request:</label><br>
        <textarea id="reason" name="reason" rows="4" cols="50" required></textarea><br><br>

        <button type="submit">Submit Request</button>
    </form>
</div>

</body>
</html>