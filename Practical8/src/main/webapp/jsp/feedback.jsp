<%@ page import="java.util.List, dao.FeedbackDao, models.Feedback" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Worker Feedback</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 20px 0;
        }
        h2 {
            text-align: center;
            color: #333;
            padding-top: 20px;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        p {
            text-align: center;
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>

<header>
    <h2>Feedback for Your Work</h2>
</header>

<div class="container">
    <%
        Integer workerId = (Integer) session.getAttribute("workerId");

        if (workerId != null) {
            FeedbackDao feedbackDao = new FeedbackDao();
            List<Feedback> feedbackList = feedbackDao.getAllFeedbackForWorker(workerId);

            if (!feedbackList.isEmpty()) {
    %>
                <table>
                    <tr>
                        <th>Feedback</th>
                        <th>Rating</th>
                        <th>Given By (Admin)</th>
                    </tr>
    <%
                for (Feedback feedback : feedbackList) {
    %>
                    <tr>
                        <td><%= feedback.getFeedbackText() %></td>
                        <td><%= feedback.getRating() %></td>
                        <td><%= feedback.getAdminName() %></td>
                    </tr>
    <%
                }
    %>
                </table>
    <%
            } else {
                out.println("<p>No feedback available yet.</p>");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    %>
</div>

</body>
</html>
