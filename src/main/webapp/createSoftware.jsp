<%@ page session="true" %>
<%
    // Check if the user is an Admin; otherwise, redirect to login page
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Admin")) {
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
        /* General styling */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        
        /* Header styling */
        .header {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            border-bottom: 2px solid #333;
            box-sizing: border-box;
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .logout-button {
            font-size: 16px;
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .logout-button:hover {
            background-color: #0056b3;
        }

        /* Form styling */
        form {
            display: flex;
            flex-direction: column;
            align-items: left;
            margin-top: 20px;
        }

        label, input, textarea {
            margin-bottom: 10px;
        }

        button[type="submit"] {
            font-size: 16px;
            padding: 10px 20px;
            cursor: pointer;
        }
        .access-level{
        display: flex
        
        
        
        }
    </style>
    
    
    
   
</head>
<body>
<body>

<!-- Header with User Management title and Logout button -->
<div class="header">
    <h2>User Management</h2>
    <form action="LogoutServlet" method="get">
        <button type="submit" class="logout-button">Logout</button>
    </form>
</div>

<h2 class="heading">Create New Software</h2>
<form action="SoftwareServlet" method="post">
    <label for="name">Software Name:</label>
    <input type="text" id="name" name="name" required>

    <label for="description">Description:</label><br>
    <textarea id="description" name="description" rows="4" cols="50" required></textarea><br>

    <label>Access Levels:</label><br>
    <div  class="access-level">
    <input type="checkbox" name="accessLevel" value="Read" /> <span>Read</span>
    </div>
    <div  class="access-level">
    <input type="checkbox" name="accessLevel" value="Write" /> <span>Write</span>
    </div> 
    <div  class="access-level">
    <input type="checkbox" name="accessLevel" value="Admin" /><span>Admin</span>
    </div>

    <button type="submit">Add Software</button>
</form>

</body>
</html>

















   