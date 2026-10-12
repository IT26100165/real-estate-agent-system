package com.realestate.system.model;

public class Review {
    private String id;
    private String clientId;    // FK to Client
    private String agentId;     // FK to Agent
    private int rating;         // 1-5
    private String comment;
    private String reviewDate;
    private String moderationStatus; // Pending, Approved, Rejected

    public Review(String id, String clientId, String agentId, int rating,
                  String comment, String reviewDate, String moderationStatus) {
        this.id = id;
        this.clientId = clientId;
        this.agentId = agentId;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.moderationStatus = moderationStatus;
    }

    public String toFileLine() {
        return id + "|" + clientId + "|" + agentId + "|" + rating + "|"
                + comment + "|" + reviewDate + "|" + moderationStatus;
    }

    public static Review fromFileLine(String line) {
        String[] parts = line.split("\\|");
        return new Review(parts[0], parts[1], parts[2],
                Integer.parseInt(parts[3]), parts[4], parts[5], parts[6]);
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }

    public String getAgentId() { return agentId; }
    public void setAgentId(String agentId) { this.agentId = agentId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getReviewDate() { return reviewDate; }
    public void setReviewDate(String reviewDate) { this.reviewDate = reviewDate; }

    public String getModerationStatus() { return moderationStatus; }
    public void setModerationStatus(String moderationStatus) { this.moderationStatus = moderationStatus; }
}