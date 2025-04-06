package servlets;

import dao.JobDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/AddJobServlet")
public class AddJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String workerEmail = (String) session.getAttribute("email");

        if (workerEmail == null) {
            System.out.println(" ERROR: Worker Email is NULL! Redirecting to login.");
            response.sendRedirect("jsp/login.jsp");
            return;
        }


        Integer workerIdObj = (Integer) session.getAttribute("workerId");
        int workerId = (workerIdObj != null) ? workerIdObj : 0;

        System.out.println(" DEBUG: Worker ID from session: " + workerId);

        if (workerId == 0) {

            JobDao jobDao = new JobDao();
            workerId = jobDao.getWorkerIdByEmail(workerEmail);
            if (workerId != -1) {
                session.setAttribute("workerId", workerId); // Store in session
                System.out.println(" DEBUG: Worker ID found from DB: " + workerId);
            } else {
                System.out.println(" ERROR: Worker ID not found for Email: " + workerEmail);
                response.sendRedirect("jsp/enterJob.jsp?error=workerNotFound");
                return;
            }
        }

        String jobDescription = request.getParameter("jobDescription");
        if (jobDescription == null || jobDescription.trim().isEmpty()) {
            System.out.println(" ERROR: Job Description is empty!");
            response.sendRedirect("jsp/enterJob.jsp?error=emptyJob");
            return;
        }

        JobDao jobDao = new JobDao();
        boolean jobAdded = jobDao.addJob(workerId, jobDescription);

        if (jobAdded) {
            System.out.println(" DEBUG: Job successfully added for Worker ID: " + workerId);
            response.sendRedirect("jsp/workerDashboard.jsp?success=jobAdded");
        } else {
            System.out.println(" ERROR: Job insertion failed for Worker ID: " + workerId);
            response.sendRedirect("jsp/enterJob.jsp?error=failed");
        }
    }
}
