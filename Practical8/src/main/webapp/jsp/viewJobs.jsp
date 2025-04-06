<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, dao.JobDao, models.Job" %>

<%
    String workerEmail = (String) session.getAttribute("workerEmail");
    if (workerEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    JobDao jobDao = new JobDao();
    List<Job> jobs = jobDao.getJobsByWorkerEmail(workerEmail);
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Jobs Done</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            font-size: 2em;
            text-align: center;
            margin-bottom: 30px;
        }

        a {
            display: block;
            text-align: center;
            font-size: 18px;
            color: #4CAF50;
            text-decoration: none;
            margin-bottom: 30px;
        }

        a:hover {
            color: #45a049;
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
        }

        td {
            background-color: #f9f9f9;
        }

        tr:nth-child(even) td {
            background-color: #f1f1f1;
        }

        .action-column {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Style for a table that looks professional */
        .table-container {
            overflow-x: auto;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Your Completed Jobs</h2>

    <a href="workerDashboard.jsp">Back to Dashboard</a>

    <div class="table-container">
        <table>
            <tr>
                <th>Job ID</th>
                <th>Description</th>
                <th>Status</th>
            </tr>
            <% for (Job job : jobs) { %>
                <tr>
                    <td><%= job.getJobId() %></td>
                    <td><%= job.getJobDescription() %></td>
                    <td><%= job.getStatus() %></td>
                </tr>
            <% } %>
        </table>
    </div>
</div>

</body>
</html>
