<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Company Management System</title>
    <style>
        /* General Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            text-align: center;
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        /* Navigation Links */
        .links {
            margin-top: 20px;
        }

        a {
            text-decoration: none;
            color: #4CAF50;
            font-size: 18px;
            font-weight: bold;
            margin: 0 15px;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Welcome to Company Management System</h2>
        <div class="links">
            <a href="jsp/login.jsp">Login</a>
            <a href="jsp/register.jsp">Register</a>
        </div>
    </div>

</body>
</html>
