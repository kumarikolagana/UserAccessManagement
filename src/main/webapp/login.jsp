
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        /* Center content on the page */
        body, html {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }

        /* Container styling for the form */
        .container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Form styling */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label, input {
            margin-bottom: 10px;
            font-size: 16px;
        }

        /* Button styling */
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        button {
            font-size: 16px;
            padding: 10px 20px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Error message styling */
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <div class="button-group">
                <button type="submit">Login</button>
                <!-- Logout button (adjust the action URL as needed) -->
                <form action="LogoutServlet" method="post" style="display:inline;">
                    <button type="submit">Logout</button>
                </form>
            </div>
        </form>

        <!-- Error message display -->
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message"><%= request.getParameter("error") %></p>
        <% } %>
    </div>
</body>
</html>
