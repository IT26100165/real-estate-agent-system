package com.realestate.system.service;

import com.realestate.system.model.Property;
import com.realestate.system.util.FileManager;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PropertyService {

    private List<Property> properties = new ArrayList<>();

    @PostConstruct
    public void init() {
        loadFromFile();
    }

    public void loadFromFile() {
        properties.clear();
        List<String> lines = FileManager.readFile("properties.txt");
        for (String line : lines) {
            properties.add(Property.fromFileLine(line));
        }
    }

    public void saveToFile() {
        List<String> lines = new ArrayList<>();
        for (Property p : properties) {
            lines.add(p.toFileLine());
        }
        FileManager.writeFile("properties.txt", lines);
    }

    // CREATE
    public boolean addProperty(Property property) {
        if (searchById(property.getId()) != null) {
            return false; // duplicate ID
        }
        properties.add(property);
        saveToFile();
        return true;
    }

    // READ - all
    public List<Property> getAllProperties() {
        return properties;
    }

    // READ - by ID
    public Property searchById(String id) {
        for (Property p : properties) {
            if (p.getId().equals(id)) return p;
        }
        return null;
    }

    // READ - by Agent
    public List<Property> getByAgentId(String agentId) {
        List<Property> result = new ArrayList<>();
        for (Property p : properties) {
            if (p.getListingAgentId().equals(agentId)) result.add(p);
        }
        return result;
    }

    // READ - filter by type
    public List<Property> getByType(String type) {
        List<Property> result = new ArrayList<>();
        for (Property p : properties) {
            if (p.getPropertyType().equalsIgnoreCase(type)) result.add(p);
        }
        return result;
    }

    // READ - filter by location (partial match)
    public List<Property> searchByLocation(String location) {
        List<Property> result = new ArrayList<>();
        for (Property p : properties) {
            if (p.getLocation().toLowerCase().contains(location.toLowerCase())) {
                result.add(p);
            }
        }
        return result;
    }

    // UPDATE
    public boolean updateProperty(Property updated) {
        Property existing = searchById(updated.getId());
        if (existing == null) return false;

        existing.setTitle(updated.getTitle());
        existing.setLocation(updated.getLocation());
        existing.setPrice(updated.getPrice());
        existing.setPropertyType(updated.getPropertyType());
        existing.setBedrooms(updated.getBedrooms());
        existing.setBathrooms(updated.getBathrooms());
        existing.setDescription(updated.getDescription());
        existing.setListingAgentId(updated.getListingAgentId());
        existing.setAvailabilityStatus(updated.getAvailabilityStatus());
        // listedDate does not change

        saveToFile();
        return true;
    }

    // DELETE
    public boolean deleteProperty(String id) {
        Property existing = searchById(id);
        if (existing == null) return false;
        properties.remove(existing);
        saveToFile();
        return true;
    }
}