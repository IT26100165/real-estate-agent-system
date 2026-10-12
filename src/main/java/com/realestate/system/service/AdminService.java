package com.realestate.system.service;

import com.realestate.system.model.Admin;
import com.realestate.system.util.FileManager;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AdminService {

    private List<Admin> admins = new ArrayList<>();

    @PostConstruct
    public void init() {
        loadFromFile();
    }

    public void loadFromFile() {
        admins.clear();
        List<String> lines = FileManager.readFile("admins.txt");
        for (String line : lines) {
            admins.add(Admin.fromFileLine(line));
        }
    }

    public void saveToFile() {
        List<String> lines = new ArrayList<>();
        for (Admin a : admins) {
            lines.add(a.toFileLine());
        }
        FileManager.writeFile("admins.txt", lines);
    }

    // CREATE
    public boolean addAdmin(Admin admin) {
        if (searchById(admin.getId()) != null) {
            return false;
        }
        admins.add(admin);
        saveToFile();
        return true;
    }

    // READ - all
    public List<Admin> getAllAdmins() {
        return admins;
    }

    // READ - by ID
    public Admin searchById(String id) {
        for (Admin a : admins) {
            if (a.getId().equals(id)) return a;
        }
        return null;
    }

    // READ - by email
    public Admin searchByEmail(String email) {
        for (Admin a : admins) {
            if (a.getEmail().equalsIgnoreCase(email)) return a;
        }
        return null;
    }

    // UPDATE
    public boolean updateAdmin(Admin updated) {
        Admin existing = searchById(updated.getId());
        if (existing == null) return false;

        existing.setName(updated.getName());
        existing.setEmail(updated.getEmail());
        existing.setPassword(updated.getPassword());
        existing.setPermissions(updated.getPermissions());
        existing.setLastLogin(updated.getLastLogin());
        existing.setActivityLog(updated.getActivityLog());

        saveToFile();
        return true;
    }

    // DELETE
    public boolean deleteAdmin(String id) {
        Admin existing = searchById(id);
        if (existing == null) return false;
        admins.remove(existing);
        saveToFile();
        return true;
    }

    // AUTHENTICATE
    public Admin authenticate(String email, String password) {
        Admin a = searchByEmail(email);
        if (a != null && a.getPassword().equals(password)) {
            return a;
        }
        return null;
    }
}