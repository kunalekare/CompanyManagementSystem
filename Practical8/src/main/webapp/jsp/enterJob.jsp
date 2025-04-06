<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, dao.JobDao" %>

<%
    HttpSession sessionObj = request.getSession();
    String workerEmail = (String) sessionObj.getAttribute("email");  // Fixed attribute name

    Integer workerId = (Integer) sessionObj.getAttribute("workerId"); // Retrieve Worker ID from session
    if (workerId == null || workerId == 0) {
        JobDao jobDao = new JobDao();
        workerId = jobDao.getWorkerIdByEmail(workerEmail);
        if (workerId != -1) {
            sessionObj.setAttribute("workerId", workerId); // Store Worker ID in session
        } else {
            response.sendRedirect("login.jsp?error=workerNotFound"); // Redirect to login if Worker ID not found
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Enter Job</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 20px 0;
        }
        header h2 {
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .container p {
            font-size: 16px;
            color: #333;
        }
        .debug-info {
            background-color: #f2f2f2;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .debug-info ul {
            list-style: none;
            padding: 0;
        }
        .debug-info li {
            margin: 5px 0;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        textarea {
            width: 100%;
            padding: 10px;
            height: 150px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: none;
            font-size: 14px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            color: #4CAF50;
            text-decoration: none;
            font-size: 16px;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>
        <h2>Submit Job Details</h2>
    </header>

    <div class="container">
        <div class="debug-info">
            <p><strong>Debug Info:</strong></p>
            <ul>
                <li>Worker Email: <%= (workerEmail != null) ? workerEmail : "Not Set" %></li>
                <li>Worker ID: <%= (workerId != null) ? workerId : "Not Set" %></li>
            </ul>
        </div>

        <form action="../AddJobServlet" method="post">
            <label for="jobDescription">Job Description:</label>
            <textarea id="jobDescription" name="jobDescription" required></textarea>
            <input type="submit" value="Submit Job">
        </form>

        <a href="workerDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
