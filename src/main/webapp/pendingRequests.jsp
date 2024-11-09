<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    // Check if the user is a Manager; otherwise, redirect to login page
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Manager")) {
        response.sendRedirect("login.jsp?error=Access+Denied");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
     <style>
        /* Page styling */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        /* Container styling */
        .container {
            width: 90%;
            max-width: 1000px;
            margin: auto;
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

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #333;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        button {
            margin: 5px;
            padding: 6px 12px;
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

    <h2>Pending Access Requests</h2>
    <form action="ApprovalServlet" method="post">
        <table>
            <tr>
                <th>Employee Name</th>
                <th>Software Name</th>
                <th>Access Type</th>
                <th>Reason</th>
                <th>Action</th>
            </tr>
            <%
                // Retrieve pending requests from the database
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/users", "root", "W7301@jqir#");
                    
                    String sql = "SELECT requests.id, users.username AS employee_name, software.name AS software_name, requests.access_type, requests.reason " +
                                 "FROM requests " +
                                 "JOIN users ON requests.user_id = users.id " +
                                 "JOIN software ON requests.software_id = software.id " +
                                 "WHERE requests.status = 'Pending'";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();

                    // Display each pending request in a table row
                    while (rs.next()) {
                        int requestId = rs.getInt("id");
                        String employeeName = rs.getString("employee_name");
                        String softwareName = rs.getString("software_name");
                        String accessType = rs.getString("access_type");
                        String reason = rs.getString("reason");
            %>
                        <tr>
                            <td><%= employeeName %></td>
                            <td><%= softwareName %></td>
                            <td><%= accessType %></td>
                            <td><%= reason %></td>
                            <td>
                                <button type="submit" name="action" value="approve_<%= requestId %>">Approve</button>
                                <button type="submit" name="action" value="reject_<%= requestId %>">Reject</button>
                            </td>
                        </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </form>
</div>

</body>   
    
    