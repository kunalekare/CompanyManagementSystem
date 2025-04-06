<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.JobDao, java.util.List, models.Job" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Tasks</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
            font-size: 2em;
            margin-bottom: 20px;
        }

        a {
            display: inline-block;
            text-align: center;
            font-size: 18px;
            color: #4CAF50;
            text-decoration: none;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #fff;
            border: 2px solid #4CAF50;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        a:hover {
            color: white;
            background-color: #4CAF50;
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
    <h2>All Submitted Tasks</h2>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Worker Email</th>
                    <th>Job Description</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    JobDao jobDao = new JobDao();
                    List<Job> jobs = jobDao.getAllJobs();
                    for (Job job : jobs) {
                %>
                <tr>
                    <td><%= job.getWorkerEmail() %></td>
                    <td><%= job.getJobDescription() %></td>
                    <td><%= job.getStatus() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <a href="adminDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>
