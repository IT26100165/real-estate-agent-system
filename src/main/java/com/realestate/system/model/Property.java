package com.realestate.system.model;

public class Property {
    private String id;
    private String title;
    private String location;
    private double price;
    private String propertyType;   // Apartment, House, Land, Commercial, Luxury
    private int bedrooms;
    private int bathrooms;
    private String description;
    private String listingAgentId; // FK to Agent
    private String listedDate;
    private String availabilityStatus; // Available, Sold, Rented

    public Property(String id, String title, String location, double price,
                    String propertyType, int bedrooms, int bathrooms,
                    String description, String listingAgentId,
                    String listedDate, String availabilityStatus) {
        this.id = id;
        this.title = title;
        this.location = location;
        this.price = price;
        this.propertyType = propertyType;
        this.bedrooms = bedrooms;
        this.bathrooms = bathrooms;
        this.description = description;
        this.listingAgentId = listingAgentId;
        this.listedDate = listedDate;
        this.availabilityStatus = availabilityStatus;
    }

    // Convert to file line
    public String toFileLine() {
        return id + "|" + title + "|" + location + "|" + price + "|"
                + propertyType + "|" + bedrooms + "|" + bathrooms + "|"
                + description + "|" + listingAgentId + "|"
                + listedDate + "|" + availabilityStatus;
    }

    // Create from file line
    public static Property fromFileLine(String line) {
        String[] parts = line.split("\\|");
        return new Property(parts[0], parts[1], parts[2],
                Double.parseDouble(parts[3]), parts[4],
                Integer.parseInt(parts[5]), Integer.parseInt(parts[6]),
                parts[7], parts[8], parts[9], parts[10]);
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getPropertyType() { return propertyType; }
    public void setPropertyType(String propertyType) { this.propertyType = propertyType; }

    public int getBedrooms() { return bedrooms; }
    public void setBedrooms(int bedrooms) { this.bedrooms = bedrooms; }

    public int getBathrooms() { return bathrooms; }
    public void setBathrooms(int bathrooms) { this.bathrooms = bathrooms; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getListingAgentId() { return listingAgentId; }
    public void setListingAgentId(String listingAgentId) { this.listingAgentId = listingAgentId; }

    public String getListedDate() { return listedDate; }
    public void setListedDate(String listedDate) { this.listedDate = listedDate; }

    public String getAvailabilityStatus() { return availabilityStatus; }
    public void setAvailabilityStatus(String availabilityStatus) { this.availabilityStatus = availabilityStatus; }
}