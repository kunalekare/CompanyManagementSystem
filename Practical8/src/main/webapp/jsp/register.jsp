<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .registration-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        input, select {
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            width: 100%;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-size: 14px;
        }

        .success-message {
            color: green;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="registration-container">
    <h2>Register</h2>

    <% String error = request.getParameter("error"); %>
    <% if ("userExists".equals(error)) { %>
        <p class="error-message">This email is already registered.</p>
    <% } else if ("failed".equals(error)) { %>
        <p class="error-message">Registration failed. Please try again.</p>
    <% } %>

    <% String success = request.getParameter("success"); %>
    <% if ("registered".equals(success)) { %>
        <p class="success-message">Registration successful! You can now log in.</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="password" name="password" placeholder="Password" required>

        <!-- Role Selection -->
        <select name="role" required>
            <option value="worker">Worker</option>
            <option value="admin">Admin</option>
        </select>

        <input type="submit" value="Register">
    </form>

    <a href="login.jsp">Back to Login</a>
</div>

</body>
</html>
