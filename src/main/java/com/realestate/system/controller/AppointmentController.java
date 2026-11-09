package com.realestate.system.controller;

import com.realestate.system.exception.ResourceNotFoundException;
import com.realestate.system.model.Agent;
import com.realestate.system.model.Appointment;
import com.realestate.system.model.Client;
import com.realestate.system.model.User;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.AppointmentService;
import com.realestate.system.service.ClientService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/appointments")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private AgentService agentService;

    private boolean canBook(HttpSession session) {
        String role = (String) session.getAttribute("role");
        if ("ADMIN".equals(role)) {
            return "FULL_ACCESS".equals(session.getAttribute("adminPermissions"));
        }
        return "CLIENT".equals(role);
    }

    private boolean canModifySpecificAppointment(HttpSession session, Appointment appointment) {
        String role = (String) session.getAttribute("role");
        if ("ADMIN".equals(role)) return "FULL_ACCESS".equals(session.getAttribute("adminPermissions"));
        if ("AGENT".equals(role)) {
            User currentUser = (User) session.getAttribute("user");
            return currentUser != null && currentUser.getId().equals(appointment.getAgentId());
        }
        return false;
    }

    @GetMapping("/list")
    public String listAppointments(Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";

        User user = (User) session.getAttribute("user");
        List<Appointment> appointments = appointmentService.getAllAppointments();

        if ("AGENT".equals(user.getRole())) {
            appointments = appointments.stream().filter(a -> a.getAgentId().equals(user.getId())).collect(Collectors.toList());
        } else if ("CLIENT".equals(user.getRole())) {
            appointments = appointments.stream().filter(a -> a.getClientId().equals(user.getId())).collect(Collectors.toList());
        }

        model.addAttribute("appointments", appointments);
        model.addAttribute("clientNames", buildClientNameMap(appointments));
        model.addAttribute("agentNames", buildAgentNameMap(appointments));
        return "appointment-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canBook(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: Agents and Read-Only Admins cannot book appointments.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/appointments/list";
        }

        User user = (User) session.getAttribute("user");

        // Only load the full client list if an Admin is booking.
        // If a client is booking, they don't need to see other clients.
        if ("ADMIN".equals(user.getRole())) {
            model.addAttribute("clients", clientService.getAllClients());
        }

        model.addAttribute("agents", agentService.getAllAgents());
        return "appointment-add";
    }

    @PostMapping("/add")
    public String addAppointment(@RequestParam(required = false) String clientId, @RequestParam String id, @RequestParam String agentId, @RequestParam String date, @RequestParam String timeSlot, @RequestParam String status, @RequestParam String propertyDescription, @RequestParam String notes, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canBook(session)) return "redirect:/appointments/list";

        User user = (User) session.getAttribute("user");

        // SPOOFING PROTECTION: If it's a client booking, force their own ID.
        if ("CLIENT".equals(user.getRole())) {
            clientId = user.getId();
        }

        Appointment appt = new Appointment(id, clientId, agentId, date, timeSlot, status, propertyDescription, notes);
        if (!appointmentService.addAppointment(appt)) {
            model.addAttribute("error", "Conflict detected or Duplicate ID.");
            if ("ADMIN".equals(user.getRole())) model.addAttribute("clients", clientService.getAllClients());
            model.addAttribute("agents", agentService.getAllAgents());
            return "appointment-add";
        }
        redirectAttributes.addFlashAttribute("message", "Appointment booked for " + date + "!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/appointments/list";
    }

    // ... Keep the rest of the methods (search, edit, delete) exactly as they are in your current file.

    @GetMapping("/search")
    public String showSearchForm(HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        return "appointment-search";
    }

    @GetMapping("/search/results")
    public String searchAppointment(@RequestParam String id, Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        Appointment appt = appointmentService.searchById(id);
        if (appt == null) throw new ResourceNotFoundException("No appointment exists with the ID: " + id);
        model.addAttribute("appointment", appt);
        model.addAttribute("searchedId", id);
        model.addAttribute("clientName", clientService.searchById(appt.getClientId()) != null ? clientService.searchById(appt.getClientId()).getName() : "Unknown");
        model.addAttribute("agentName", agentService.searchById(appt.getAgentId()) != null ? agentService.searchById(appt.getAgentId()).getName() : "Unknown");
        return "appointment-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        Appointment appt = appointmentService.searchById(id);
        if (appt == null) throw new ResourceNotFoundException("Cannot edit. Appointment not found with ID: " + id);
        if (!canModifySpecificAppointment(session, appt)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: You can only edit your own appointments.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/appointments/list";
        }
        model.addAttribute("appointment", appt);
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "appointment-edit";
    }

    @PostMapping("/edit")
    public String updateAppointment(@RequestParam String id, @RequestParam String clientId, @RequestParam String agentId, @RequestParam String date, @RequestParam String timeSlot, @RequestParam String status, @RequestParam String propertyDescription, @RequestParam String notes, HttpSession session, RedirectAttributes redirectAttributes) {
        Appointment appt = appointmentService.searchById(id);
        if (appt == null) throw new ResourceNotFoundException("Appointment not found.");
        if (!canModifySpecificAppointment(session, appt)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: You can only edit your own appointments.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/appointments/list";
        }
        appointmentService.updateAppointment(new Appointment(id, clientId, agentId, date, timeSlot, status, propertyDescription, notes));
        redirectAttributes.addFlashAttribute("message", "Appointment updated successfully.");
        redirectAttributes.addFlashAttribute("toastType", "info");
        return "redirect:/appointments/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteAppointment(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        Appointment appt = appointmentService.searchById(id);
        if (appt == null) throw new ResourceNotFoundException("Appointment not found.");
        if (!canModifySpecificAppointment(session, appt)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: You can only delete your own appointments.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/appointments/list";
        }
        appointmentService.deleteAppointment(id);
        redirectAttributes.addFlashAttribute("message", "Appointment cancelled and deleted.");
        redirectAttributes.addFlashAttribute("toastType", "error");
        return "redirect:/appointments/list";
    }

    private Map<String, String> buildClientNameMap(List<Appointment> appointments) {
        Map<String, String> map = new HashMap<>();
        for (Appointment a : appointments) {
            if (!map.containsKey(a.getClientId())) {
                Client c = clientService.searchById(a.getClientId());
                map.put(a.getClientId(), c != null ? c.getName() : "Unknown");
            }
        }
        return map;
    }
    private Map<String, String> buildAgentNameMap(List<Appointment> appointments) {
        Map<String, String> map = new HashMap<>();
        for (Appointment a : appointments) {
            if (!map.containsKey(a.getAgentId())) {
                Agent ag = agentService.searchById(a.getAgentId());
                map.put(a.getAgentId(), ag != null ? ag.getName() : "Unknown");
            }
        }
        return map;
    }
}