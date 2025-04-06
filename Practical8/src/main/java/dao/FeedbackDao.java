package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.Feedback;

public class FeedbackDao {

    // ✅ Add a feedback entry
    public boolean addFeedback(int jobId, int adminId, String feedbackText, int rating) {
        String sql = "INSERT INTO Feedback (job_id, admin_id, feedback_text, rating) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, jobId);
            stmt.setInt(2, adminId);
            stmt.setString(3, feedbackText);
            stmt.setInt(4, rating);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get all feedback for a specific worker
    public List<Feedback> getAllFeedbackForWorker(int workerId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT F.feedback_id, F.feedback_text, F.rating, A.name AS admin_name " +
                "FROM Feedback F " +
                "INNER JOIN Job J ON F.job_id = J.job_id " +
                "INNER JOIN Admin A ON F.admin_id = A.admin_id " +
                "WHERE J.worker_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, workerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt("feedback_id"),
                        rs.getString("feedback_text"),
                        rs.getInt("rating"),
                        rs.getString("admin_name")
                );
                feedbackList.add(feedback);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
}
