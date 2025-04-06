<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("jsp/login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        h2 {
            text-align: center;
            color: #333;
            padding-top: 60px;
            font-size: 2.5em;
        }

        .navbar {
            display: flex;
            justify-content: center;
            margin-top: 40px;
            gap: 20px;
        }

        .navbar a {
            font-size: 18px;
            padding: 12px 25px;
            background-color: #fff;
            color: #333;
            border-radius: 30px;
            text-decoration: none;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .navbar a:hover {
            background-color: #4CAF50;
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .navbar a:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(72, 197, 80, 0.5);
        }

        footer {
            text-align: center;
            margin-top: 50px;
            font-size: 14px;
            color: #777;
        }

        footer a {
            color: #4CAF50;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

    <h2>Welcome Admin</h2>

    <div class="navbar">
        <a href="addWorker.jsp">Add Worker</a>
        <a href="viewTasks.jsp">View Tasks</a>
        <a href="reviewJob.jsp">Review Jobs</a>
        <a href="login.jsp">Logout</a>
    </div>

    <footer>
        <p>&copy; 2025 Your Company. <a href="privacy-policy.jsp">Privacy Policy</a></p>
    </footer>

</body>
</html>
