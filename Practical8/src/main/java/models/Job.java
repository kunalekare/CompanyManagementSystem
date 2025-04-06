package models;

public class Job {
    private int jobId;
    private int workerId;
    private String workerName;
    private String workerEmail;
    private String jobDescription;
    private String status;


    public Job(int jobId, int workerId, String workerName, String workerEmail, String jobDescription, String status) {
        this.jobId = jobId;
        this.workerId = workerId;
        this.workerName = workerName;
        this.workerEmail = workerEmail;
        this.jobDescription = jobDescription;
        this.status = status;
    }


    public Job() {}

    public int getJobId() { return jobId; }
    public int getWorkerId() { return workerId; }
    public String getWorkerName() { return workerName; }
    public String getWorkerEmail() { return workerEmail; }
    public String getJobDescription() { return jobDescription; }
    public String getStatus() { return status; }


    public void setStatus(String status) {
        this.status = status;
    }
}
