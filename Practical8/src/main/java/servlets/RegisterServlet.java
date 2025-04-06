package servlets;

import dao.WorkerDao;
import dao.AdminDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        WorkerDao workerDao = new WorkerDao();
        AdminDao adminDao = new AdminDao();


        if (workerDao.workerExists(email) || adminDao.adminExists(email)) {
            response.sendRedirect("jsp/register.jsp?error=userExists");
            return;
        }

        boolean isRegistered = false;


        if ("worker".equals(role)) {
            isRegistered = workerDao.addWorker(name, email, password);
        } else if ("admin".equals(role)) {
            isRegistered = adminDao.addAdmin(name, email, password);
        }

        if (isRegistered) {
            response.sendRedirect("jsp/login.jsp?success=registered");
        } else {
            response.sendRedirect("jsp/register.jsp?error=failed");
        }
    }
}
