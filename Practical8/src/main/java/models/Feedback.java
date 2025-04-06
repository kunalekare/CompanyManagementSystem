package models;

public class Feedback {
    private int feedbackId;
    private String feedbackText;
    private int rating;
    private String adminName; // To show which admin gave the feedback

    public Feedback(int feedbackId, String feedbackText, int rating, String adminName) {
        this.feedbackId = feedbackId;
        this.feedbackText = feedbackText;
        this.rating = rating;
        this.adminName = adminName;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public String getFeedbackText() {
        return feedbackText;
    }

    public int getRating() {
        return rating;
    }

    public String getAdminName() {
        return adminName;
    }
}
