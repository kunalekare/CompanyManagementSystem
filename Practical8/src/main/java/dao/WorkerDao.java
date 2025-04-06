package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WorkerDao {


    public boolean workerExists(String email) {
        String sql = "SELECT 1 FROM Worker WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Returns true if a record is found

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean addWorker(String name, String email, String password) {
        if (workerExists(email)) {
            return false; // Prevent adding duplicate workers
        }

        String sql = "INSERT INTO Worker (name, email, password) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean authenticateWorker(String email, String password) {
        String sql = "SELECT * FROM Worker WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get Worker ID by Email (Required for session handling)
    public int getWorkerIdByEmail(String email) {
        String sql = "SELECT worker_id FROM Worker WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("worker_id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;  // Worker not found
    }


    public List<String> getAllJobsForWorker(int workerId) {
        List<String> jobs = new ArrayList<>();
        String sql = "SELECT job_description FROM Job WHERE worker_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, workerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                jobs.add(rs.getString("job_description"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jobs;
    }


    public List<String> getAllJobs() {
        List<String> jobs = new ArrayList<>();
        String sql = "SELECT W.name, J.job_description FROM Job J INNER JOIN Worker W ON J.worker_id = W.worker_id";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String jobEntry = "Worker: " + rs.getString("name") + " | Job: " + rs.getString("job_description");
                jobs.add(jobEntry);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // ✅ Workers can Request Clarifications on Feedback
    public boolean requestClarification(int workerId, String clarificationText) {
        String sql = "INSERT INTO ClarificationRequests (worker_id, request_text) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, workerId);
            stmt.setString(2, clarificationText);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public List<String> getWorkerFeedback(int workerId) {
        List<String> feedbackList = new ArrayList<>();
        String sql = "SELECT feedback, rating FROM Feedback WHERE worker_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, workerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String feedbackEntry = "Rating: " + rs.getInt("rating") + " | Feedback: " + rs.getString("feedback");
                feedbackList.add(feedbackEntry);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
}
