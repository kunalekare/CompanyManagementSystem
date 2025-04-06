<%@ page import="java.util.List, dao.JobDao, models.Job" %>

<%
    JobDao jobDao = new JobDao();
    List<Job> jobs = jobDao.getAllJobs();
    Integer adminId = (Integer) session.getAttribute("adminId");

    // ✅ Debugging logs
    System.out.println("🔹 DEBUG: Session adminId = " + session.getAttribute("adminId"));

    if (adminId == null) {
        System.out.println("❌ ERROR: No adminId found in session. Redirecting to login.");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Review Jobs</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
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

        form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        select,
        textarea {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            width: 100%;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        label {
            font-size: 14px;
            color: #333;
        }

        .action-column {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .action-column input[type="submit"] {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Review Jobs</h2>

    <table>
        <tr>
            <th>Job ID</th>
            <th>Worker Name</th>
            <th>Email</th>
            <th>Description</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <% for (Job job : jobs) { %>
            <tr>
                <td><%= job.getJobId() %></td>
                <td><%= job.getWorkerName() %></td>
                <td><%= job.getWorkerEmail() %></td>
                <td><%= job.getJobDescription() %></td>
                <td><%= job.getStatus() %></td>
                <td>
                    <form action="../ReviewJobServlet" method="post">
                        <input type="hidden" name="jobId" value="<%= job.getJobId() %>">
                        <input type="hidden" name="adminId" value="<%= adminId %>">

                        <div class="action-column">
                            <label for="status">Update Job Status:</label>
                            <select name="status" required>
                                <option value="Pending">Pending</option>
                                <option value="Approved">Approved</option>
                                <option value="Rejected">Rejected</option>
                            </select>

                            <label for="feedback">Feedback:</label>
                            <textarea name="feedback" rows="3"></textarea>

                            <label for="rating">Rating:</label>
                            <select name="rating">
                                <option value="1">1 - Poor</option>
                                <option value="2">2 - Fair</option>
                                <option value="3">3 - Good</option>
                                <option value="4">4 - Very Good</option>
                                <option value="5">5 - Excellent</option>
                            </select>

                            <input type="submit" value="Update">
                        </div>
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
</div>

</body>
</html>
