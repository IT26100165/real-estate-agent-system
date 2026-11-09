package com.realestate.system.model;

public class Appointment {
    private String id;
    private String clientId;      // FK to Client
    private String agentId;       // FK to Agent
    private String propertyId;    // FK to Property
    private String date;
    private String timeSlot;
    private String status;        // Pending, Confirmed, Completed, Cancelled
    private String notes;

    public Appointment(String id, String clientId, String agentId, String propertyId,
                       String date, String timeSlot, String status, String notes) {
        this.id = id;
        this.clientId = clientId;
        this.agentId = agentId;
        this.propertyId = propertyId;
        this.date = date;
        this.timeSlot = timeSlot;
        this.status = status;
        this.notes = notes;
    }

    public String toFileLine() {
        return id + "|" + clientId + "|" + agentId + "|" + propertyId + "|"
                + date + "|" + timeSlot + "|" + status + "|" + notes;
    }

    public static Appointment fromFileLine(String line) {
        String[] parts = line.split("\\|", -1);
        if (parts.length < 8) {
            System.out.println("Skipping malformed appointment line: " + line);
            return null;
        }
        return new Appointment(parts[0], parts[1], parts[2], parts[3],
                parts[4], parts[5], parts[6], parts[7]);
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }
    public String getAgentId() { return agentId; }
    public void setAgentId(String agentId) { this.agentId = agentId; }
    public String getPropertyId() { return propertyId; }
    public void setPropertyId(String propertyId) { this.propertyId = propertyId; }
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}