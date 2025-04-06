<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        input[type="email"],
        input[type="password"],
        select {
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            margin-bottom: 20px;
        }
        label {
            text-align: left;
            font-size: 14px;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Login</h2>

        <%-- Show Error Message if Login Failed --%>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <p class="error-message"><%= error %></p>
        <% } %>

        <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>

            <label for="userType">Select Role:</label>
            <select id="userType" name="userType">
                <option value="admin">Admin</option>
                <option value="worker">Worker</option>
            </select><br>

            <input type="submit" value="Login">
        </form>
    </div>

</body>
</html>
