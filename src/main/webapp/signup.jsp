
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <style>
        /* Center all content on the page */
        body, html {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }

        /* Container styling */
        .container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Form element styling */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label, input {
            margin: 5px 0;
            font-size: 16px;
        }

        button {
            margin-top: 10px;
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

        /* Style for additional buttons side by side */
        .button-group {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Sign Up</h2>
        <form action="SignUpServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <!-- Hidden field for role, defaulted to "Employee" -->
            <input type="hidden" name="role" value="Employee">

            <div class="button-group">
                <button type="submit">Sign Up</button>
                <button type="button" onclick="window.location.href='registration.jsp'">Register</button>
            </div>
        </form>
    </div>
</body>
</html>





























