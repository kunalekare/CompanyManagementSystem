package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.Job;

public class JobDao {


    public boolean addJob(int workerId, String jobDescription) {
        String sql = "INSERT INTO Job (worker_id, job_description, status) VALUES (?, ?, 'Pending')";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, workerId);
            stmt.setString(2, jobDescription);

            System.out.println(" DEBUG: Executing SQL: " + stmt.toString()); // Debug log

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println(" DEBUG: Job inserted successfully for Worker ID: " + workerId);
                return true;
            } else {
                System.out.println(" ERROR: Job insertion failed for Worker ID: " + workerId);
            }

        } catch (Exception e) {
            System.out.println(" ERROR in addJob(): " + e.getMessage());
        }
        return false;
    }


    public int getWorkerIdByEmail(String workerEmail) {
        String sql = "SELECT worker_id FROM Worker WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, workerEmail);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int workerId = rs.getInt("worker_id");
                System.out.println(" DEBUG: Worker ID found: " + workerId + " for Email: " + workerEmail);
                return workerId;
            } else {
                System.out.println(" ERROR: No Worker found for Email: " + workerEmail);
            }

        } catch (Exception e) {
            System.out.println(" ERROR in getWorkerIdByEmail(): " + e.getMessage());
        }
        return -1;  // Worker not found
    }


    public List<Job> getAllJobs() {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT J.job_id, J.job_description, J.status, W.worker_id, W.name AS worker_name, W.email AS worker_email " +
                "FROM Job J INNER JOIN Worker W ON J.worker_id = W.worker_id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Job job = new Job(
                        rs.getInt("job_id"),
                        rs.getInt("worker_id"),
                        rs.getString("worker_name"),
                        rs.getString("worker_email"),
                        rs.getString("job_description"),
                        rs.getString("status")
                );
                jobs.add(job);
            }
            System.out.println("DEBUG: Retrieved " + jobs.size() + " jobs from database.");

        } catch (Exception e) {
            System.out.println(" ERROR in getAllJobs(): " + e.getMessage());
        }
        return jobs;
    }


    public boolean updateJobStatus(int jobId, String newStatus) {
        String sql = "UPDATE Job SET status = ? WHERE job_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, jobId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println(" DEBUG: Job ID " + jobId + " status updated to " + newStatus);
                return true;
            } else {
                System.out.println(" ERROR: Failed to update job status for Job ID " + jobId);
            }

        } catch (Exception e) {
            System.out.println(" ERROR in updateJobStatus(): " + e.getMessage());
        }
        return false;
    }

    // ✅ NEW: Get Jobs by Worker Email (To allow workers to see jobs they have done)
    public List<Job> getJobsByWorkerEmail(String workerEmail) {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT job_id, job_description, status FROM Job WHERE worker_id = (SELECT worker_id FROM Worker WHERE email = ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, workerEmail);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                jobs.add(new Job(
                        rs.getInt("job_id"),
                        -1,  // No need for worker ID here
                        null, // No worker name needed
                        workerEmail,
                        rs.getString("job_description"),
                        rs.getString("status")
                ));
            }
            System.out.println(" DEBUG: Retrieved " + jobs.size() + " jobs for Worker: " + workerEmail);

        } catch (Exception e) {
            System.out.println(" ERROR in getJobsByWorkerEmail(): " + e.getMessage());
        }
        return jobs;
    }
}
