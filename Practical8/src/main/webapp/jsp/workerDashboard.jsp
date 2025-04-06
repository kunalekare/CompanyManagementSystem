<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, dao.JobDao, models.Job" %>

<%
    String workerEmail = (String) session.getAttribute("workerEmail");
    if (workerEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    JobDao jobDao = new JobDao();
    List<Job> jobs = jobDao.getJobsByWorkerEmail(workerEmail); // Fetch worker's jobs
%>

<!DOCTYPE html>
<html>
<head>
    <title>Worker Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        h3 {
            color: #333;
            font-size: 1.8em;
            margin-bottom: 20px;
        }

        a {
            font-size: 18px;
            text-decoration: none;
            color: #4CAF50;
            margin-right: 15px;
            font-weight: bold;
        }

        a:hover {
            color: #45a049;
        }

        .navbar {
            text-align: center;
            margin-top: 30px;
        }

        .navbar a {
            font-size: 18px;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .navbar a:hover {
            background-color: #4CAF50;
            color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
            text-align: center;
        }

        td {
            background-color: #f9f9f9;
            color: #333;
        }

        tr:nth-child(even) td {
            background-color: #f1f1f1;
        }

        tr:hover {
            background-color: #e0e0e0;
        }

        .table-container {
            overflow-x: auto;
        }

    </style>
</head>
<body>

<div class="container">
    <h2>Welcome Worker</h2>

    <div class="navbar">
        <a href="enterJob.jsp">Enter Job Details</a>
        <a href="viewJobs.jsp">View All Jobs Done</a>
        <a href="feedback.jsp">View Feedback</a>
        <a href="login.jsp">Logout</a>
    </div>

    <h3>Your Job History</h3>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Job ID</th>
                    <th>Description</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Job job : jobs) { %>
                <tr>
                    <td><%= job.getJobId() %></td>
                    <td><%= job.getJobDescription() %></td>
                    <td><%= job.getStatus() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
