package servlets;

import dao.WorkerDao;
import dao.AdminDao;
import java.io.IOException;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        System.out.println("🔹 Login Attempt: Email=" + email + ", UserType=" + userType);

        if (userType == null || email == null || password == null ||
                email.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("jsp/login.jsp?error=missingFields");
            return;
        }

        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        if (!Pattern.matches(emailRegex, email)) {
            response.sendRedirect("jsp/login.jsp?error=invalidEmailFormat");
            return;
        }

        if (password.length() < 6) {
            response.sendRedirect("jsp/login.jsp?error=shortPassword");
            return;
        }

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        session = request.getSession(true);

        if ("admin".equalsIgnoreCase(userType)) {
            AdminDao adminDao = new AdminDao();
            int adminId = adminDao.getAdminIdByEmail(email);

            if (adminId > 0 && adminDao.authenticateAdmin(email, password)) {
                session.setAttribute("adminId", adminId);
                session.setAttribute("adminEmail", email);
                session.setAttribute("role", "admin");
                System.out.println(" Admin login successful: " + email);
                response.sendRedirect("jsp/adminDashboard.jsp");
            } else {
                System.out.println(" Admin login failed: " + email);
                response.sendRedirect("jsp/login.jsp?error=invalidAdmin");
            }
        } else if ("worker".equalsIgnoreCase(userType)) {
            WorkerDao workerDao = new WorkerDao();
            if (workerDao.authenticateWorker(email, password)) {
                int workerId = workerDao.getWorkerIdByEmail(email);
                if (workerId > 0) {
                    session.setAttribute("workerEmail", email);
                    session.setAttribute("workerId", workerId);
                    session.setAttribute("role", "worker");
                    System.out.println(" Worker login successful: " + email);
                    response.sendRedirect("jsp/workerDashboard.jsp");
                } else {
                    System.out.println(" Worker not found: " + email);
                    response.sendRedirect("jsp/login.jsp?error=workerNotFound");
                }
            } else {
                System.out.println(" Invalid Worker credentials: " + email);
                response.sendRedirect("jsp/login.jsp?error=invalidWorker");
            }
        } else {
            System.out.println(" Invalid user type: " + userType);
            response.sendRedirect("jsp/login.jsp?error=invalidUserType");
        }
    }
}
