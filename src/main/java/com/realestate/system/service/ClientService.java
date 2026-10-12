package com.realestate.system.service;

import com.realestate.system.model.Client;
import com.realestate.system.util.FileManager;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ClientService {

    private List<Client> clients = new ArrayList<>();

    // Load clients from file when app starts
    @PostConstruct
    public void init() {
        loadFromFile();
    }

    // Load from clients.txt
    public void loadFromFile() {
        clients.clear();
        List<String> lines = FileManager.readFile("clients.txt");
        for (String line : lines) {
            clients.add(Client.fromFileLine(line));
        }
    }

    // Save to clients.txt
    public void saveToFile() {
        List<String> lines = new ArrayList<>();
        for (Client c : clients) {
            lines.add(c.toFileLine());
        }
        FileManager.writeFile("clients.txt", lines);
    }

    // CREATE
    public boolean addClient(Client client) {
        // Prevent duplicate IDs
        if (searchById(client.getId()) != null) {
            return false;
        }
        clients.add(client);
        saveToFile();
        return true;
    }

    // READ - all clients
    public List<Client> getAllClients() {
        return clients;
    }

    // READ - search by ID
    public Client searchById(String id) {
        for (Client c : clients) {
            if (c.getId().equals(id)) return c;
        }
        return null;
    }

    // READ - search by email (used for login)
    public Client searchByEmail(String email) {
        for (Client c : clients) {
            if (c.getEmail().equalsIgnoreCase(email)) return c;
        }
        return null;
    }

    // UPDATE
    public boolean updateClient(Client updated) {
        Client existing = searchById(updated.getId());
        if (existing == null) return false;

        existing.setName(updated.getName());
        existing.setEmail(updated.getEmail());
        existing.setPassword(updated.getPassword());
        existing.setPhoneNumber(updated.getPhoneNumber());
        existing.setAddress(updated.getAddress());
        existing.setPropertyPreference(updated.getPropertyPreference());
        // Registration date does not change

        saveToFile();
        return true;
    }

    // DELETE
    public boolean deleteClient(String id) {
        Client existing = searchById(id);
        if (existing == null) return false;
        clients.remove(existing);
        saveToFile();
        return true;
    }

    // AUTHENTICATE - email + password
    public Client authenticate(String email, String password) {
        Client c = searchByEmail(email);
        if (c != null && c.getPassword().equals(password)) {
            return c;
        }
        return null;
    }
}