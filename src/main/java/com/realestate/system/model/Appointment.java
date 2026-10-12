package com.realestate.system.model;

public class Appointment {
    private String id;
    private String clientId;      // FK to Client
    private String agentId;       // FK to Agent
    private String date;
    private String timeSlot;
    private String status;        // Pending, Confirmed, Completed, Cancelled
    private String propertyDescription;
    private String notes;

    public Appointment(String id, String clientId, String agentId, String date,
                       String timeSlot, String status,
                       String propertyDescription, String notes) {
        this.id = id;
        this.clientId = clientId;
        this.agentId = agentId;
        this.date = date;
        this.timeSlot = timeSlot;
        this.status = status;
        this.propertyDescription = propertyDescription;
        this.notes = notes;
    }

    // Convert to file line for appointments.txt
    public String toFileLine() {
        return id + "|" + clientId + "|" + agentId + "|" + date + "|"
                + timeSlot + "|" + status + "|" + propertyDescription + "|" + notes;
    }

    // Create from file line
    public static Appointment fromFileLine(String line) {
        String[] parts = line.split("\\|");
        return new Appointment(parts[0], parts[1], parts[2], parts[3],
                parts[4], parts[5], parts[6], parts[7]);
    }

    // Getters and Setters (Encapsulation)
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }

    public String getAgentId() { return agentId; }
    public void setAgentId(String agentId) { this.agentId = agentId; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPropertyDescription() { return propertyDescription; }
    public void setPropertyDescription(String propertyDescription) { this.propertyDescription = propertyDescription; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}