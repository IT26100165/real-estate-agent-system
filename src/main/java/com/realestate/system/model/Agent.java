package com.realestate.system.model;

public class Agent extends User {
    private String specialization;
    private String contactNumber;
    private double averageRating;
    private int totalReviews;

    public Agent(String id, String name, String email, String password,
                 String specialization, String contactNumber) {
        super(id, name, email, password);
        this.specialization = specialization;
        this.contactNumber = contactNumber;
        this.averageRating = 0.0;
        this.totalReviews = 0;
    }

    @Override
    public String getRole() {
        return "AGENT";
    }

    // Convert to file line for agents.txt
    public String toFileLine() {
        return getId() + "|" + getName() + "|" + getEmail() + "|" + getPassword()
                + "|" + specialization + "|" + contactNumber + "|"
                + averageRating + "|" + totalReviews;
    }

    // Create Agent from a line in agents.txt
    public static Agent fromFileLine(String line) {
        String[] parts = line.split("\\|");
        Agent agent = new Agent(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
        agent.setAverageRating(Double.parseDouble(parts[6]));
        agent.setTotalReviews(Integer.parseInt(parts[7]));
        return agent;
    }

    // Getters and Setters (Encapsulation)
    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }

    public int getTotalReviews() { return totalReviews; }
    public void setTotalReviews(int totalReviews) { this.totalReviews = totalReviews; }
}