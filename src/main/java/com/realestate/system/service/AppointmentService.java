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
            Appointment appt = Appointment.fromFileLine(line);
            if (appt != null) {
                appointments.add(appt);
            }
        }
    }

    public void saveToFile() {
        List<String> lines = new ArrayList<>();
        for (Appointment a : appointments) {
            lines.add(a.toFileLine());
        }
        FileManager.writeFile("appointments.txt", lines);
    }

    public boolean addAppointment(Appointment appointment) {
        if (searchById(appointment.getId()) != null) return false;
        if (hasConflict(appointment)) return false;

        appointments.add(appointment);
        saveToFile();
        return true;
    }

    public List<Appointment> getAllAppointments() {
        return appointments;
    }

    public Appointment searchById(String id) {
        for (Appointment a : appointments) {
            if (a.getId().equals(id)) return a;
        }
        return null;
    }

    public List<Appointment> getByClientId(String clientId) {
        List<Appointment> result = new ArrayList<>();
        for (Appointment a : appointments) {
            if (a.getClientId().equals(clientId)) result.add(a);
        }
        return result;
    }

    public List<Appointment> getByAgentId(String agentId) {
        List<Appointment> result = new ArrayList<>();
        for (Appointment a : appointments) {
            if (a.getAgentId().equals(agentId)) result.add(a);
        }
        return result;
    }

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

    public boolean updateAppointment(Appointment updated) {
        Appointment existing = searchById(updated.getId());
        if (existing == null) return false;

        existing.setClientId(updated.getClientId());
        existing.setAgentId(updated.getAgentId());
        existing.setDate(updated.getDate());
        existing.setTimeSlot(updated.getTimeSlot());
        existing.setStatus(updated.getStatus());

        // THIS IS THE FIX: We changed propertyDescription to propertyId
        existing.setPropertyId(updated.getPropertyId());
        existing.setNotes(updated.getNotes());

        saveToFile();
        return true;
    }

    public boolean deleteAppointment(String id) {
        Appointment existing = searchById(id);
        if (existing == null) return false;
        appointments.remove(existing);
        saveToFile();
        return true;
    }
}