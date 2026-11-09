package com.realestate.system.model;

public class Client extends User {
    private String phoneNumber;
    private String address;
    private String propertyPreference;
    private String registrationDate;

    public Client(String id, String name, String email, String password, String phoneNumber, String address,
                  String propertyPreference, String registrationDate) {
        super(id, name, email, password);
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.propertyPreference = propertyPreference;
        this.registrationDate = registrationDate;
    }

    @Override
    public String getRole() {
        return "CLIENT";
    }

    // Convert to file line for clients.txt
    public String toFileLine() {
        return getId() + "|" + getName() + "|" + getEmail() + "|" + getPassword()
                + "|" + phoneNumber + "|" + address + "|" + propertyPreference + "|" + registrationDate;
    }

    // Create Client from a line in clients.txt
    public static Client fromFileLine(String line) {
        String[] parts = line.split("\\|");
        return new Client(parts[0], parts[1], parts[2], parts[3],
                parts[4], parts[5], parts[6], parts[7]);
    }

    // Getters and Setters (Encapsulation)
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPropertyPreference() { return propertyPreference; }
    public void setPropertyPreference(String propertyPreference) { this.propertyPreference = propertyPreference; }

    public String getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(String registrationDate) { this.registrationDate = registrationDate; }
}