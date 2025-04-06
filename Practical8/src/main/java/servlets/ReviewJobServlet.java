package servlets;

import dao.FeedbackDao;
import dao.JobDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ReviewJobServlet")
public class ReviewJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jobIdStr = request.getParameter("jobId");
        String adminIdStr = request.getParameter("adminId");  // Admin ID from session or form
        String feedbackText = request.getParameter("feedback");
        String ratingStr = request.getParameter("rating");
        String status = request.getParameter("status");


        if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
            System.out.println(" ERROR: jobId is missing or empty!");
            response.sendRedirect("jsp/reviewJob.jsp?error=invalidJobId");
            return;
        }


        if (adminIdStr == null || adminIdStr.trim().isEmpty()) {
            System.out.println(" ERROR: adminId is missing!");
            response.sendRedirect("jsp/reviewJob.jsp?error=missingAdminId");
            return;
        }

        int jobId, adminId, rating;
        try {
            jobId = Integer.parseInt(jobIdStr);
            adminId = Integer.parseInt(adminIdStr);
        } catch (NumberFormatException e) {
            System.out.println(" ERROR: Invalid jobId or adminId format!");
            response.sendRedirect("jsp/reviewJob.jsp?error=invalidJobIdOrAdminId");
            return;
        }


        if (ratingStr == null || ratingStr.trim().isEmpty()) {
            rating = 0;  // Default rating
        } else {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                System.out.println(" ERROR: Invalid rating format!");
                response.sendRedirect("jsp/reviewJob.jsp?error=invalidRating");
                return;
            }
        }


        JobDao jobDao = new JobDao();
        boolean jobUpdated = jobDao.updateJobStatus(jobId, status);


        boolean feedbackSuccess = true;
        if (feedbackText != null && !feedbackText.trim().isEmpty()) {
            FeedbackDao feedbackDao = new FeedbackDao();
            feedbackSuccess = feedbackDao.addFeedback(jobId, adminId, feedbackText, rating);
        }

        if (jobUpdated && feedbackSuccess) {
            System.out.println(" Job ID " + jobId + " updated with status: " + status);
            response.sendRedirect("jsp/adminDashboard.jsp?success=jobReviewed");
        } else {
            System.out.println(" ERROR: Failed to update job or add feedback!");
            response.sendRedirect("jsp/reviewJob.jsp?error=updateFailed");
        }
    }
}
