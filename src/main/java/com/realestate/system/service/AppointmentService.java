package com.realestate.system.service;

import com.realestate.system.model.Appointment;
import com.realestate.system.util.FileManager;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AppointmentService {

    private List<Appointment> appointments = new ArrayList<>();

    @PostConstruct
    public void init() {
        loadFromFile();
    }

    public void loadFromFile() {
        appointments.clear();
        List<String> lines = FileManager.readFile("appointments.txt");
        for (String line : lines) {
            appointments.add(Appointment.fromFileLine(line));
        }
    }

    public void saveToFile() {
        List<String> lines = new ArrayList<>();
        for (Appointment a : appointments) {
            lines.add(a.toFileLine());
        }
        FileManager.writeFile("appointments.txt", lines);
    }

    // CREATE - with conflict check
    public boolean addAppointment(Appointment appointment) {
        if (searchById(appointment.getId()) != null) {
            return false; // duplicate ID
        }
        if (hasConflict(appointment)) {
            return false; // same agent at same date+time
        }
        appointments.add(appointment);
        saveToFile();
        return true;
    }

    // READ - all
    public List<Appointment> getAllAppointments() {
        return appointments;
    }

    // READ - by ID
    public Appointment searchById(String id) {
        for (Appointment a : appointments) {
            if (a.getId().equals(id)) return a;
        }
        return null;
    }

    // READ - by Client
    public List<Appointment> getByClientId(String clientId) {
        List<Appointment> result = new ArrayList<>();
        for (Appointment a : appointments) {
            if (a.getClientId().equals(clientId)) result.add(a);
        }
        return result;
    }

    // READ - by Agent
    public List<Appointment> getByAgentId(String agentId) {
        List<Appointment> result = new ArrayList<>();
        for (Appointment a : appointments) {
            if (a.getAgentId().equals(agentId)) result.add(a);
        }
        return result;
    }

    // BUSINESS LOGIC - conflict check
    public boolean hasConflict(Appointment newAppt) {
        for (Appointment a : appointments) {
            if (a.getAgentId().equals(newAppt.getAgentId())
                    && a.getDate().equals(newAppt.getDate())
                    && a.getTimeSlot().equals(newAppt.getTimeSlot())
                    && !a.getStatus().equals("Cancelled")) {
                return true;
            }
        }
        return false;
    }

    // UPDATE
    public boolean updateAppointment(Appointment updated) {
        Appointment existing = searchById(updated.getId());
        if (existing == null) return false;

        existing.setClientId(updated.getClientId());
        existing.setAgentId(updated.getAgentId());
        existing.setDate(updated.getDate());
        existing.setTimeSlot(updated.getTimeSlot());
        existing.setStatus(updated.getStatus());
        existing.setPropertyDescription(updated.getPropertyDescription());
        existing.setNotes(updated.getNotes());

        saveToFile();
        return true;
    }

    // DELETE
    public boolean deleteAppointment(String id) {
        Appointment existing = searchById(id);
        if (existing == null) return false;
        appointments.remove(existing);
        saveToFile();
        return true;
    }
}