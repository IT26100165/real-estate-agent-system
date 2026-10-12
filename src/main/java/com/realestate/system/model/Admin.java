package com.realestate.system.model;

public class Admin extends User {
    private String permissions;   // FULL_ACCESS or READ_ONLY
    private String lastLogin;
    private String activityLog;

    public Admin(String id, String name, String email, String password,
                 String permissions, String lastLogin, String activityLog) {
        super(id, name, email, password);
        this.permissions = permissions;
        this.lastLogin = lastLogin;
        this.activityLog = activityLog;
    }

    @Override
    public String getRole() {
        return "ADMIN";
    }

    // Convert to file line
    public String toFileLine() {
        return getId() + "|" + getName() + "|" + getEmail() + "|" + getPassword()
                + "|" + permissions + "|" + lastLogin + "|" + activityLog;
    }

    // Create from file line
    public static Admin fromFileLine(String line) {
        String[] parts = line.split("\\|");
        return new Admin(parts[0], parts[1], parts[2], parts[3],
                parts[4], parts[5], parts[6]);
    }

    // Getters and Setters
    public String getPermissions() { return permissions; }
    public void setPermissions(String permissions) { this.permissions = permissions; }

    public String getLastLogin() { return lastLogin; }
    public void setLastLogin(String lastLogin) { this.lastLogin = lastLogin; }

    public String getActivityLog() { return activityLog; }
    public void setActivityLog(String activityLog) { this.activityLog = activityLog; }
}