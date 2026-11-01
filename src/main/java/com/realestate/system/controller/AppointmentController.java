package com.realestate.system.controller;

import com.realestate.system.exception.ResourceNotFoundException;
import com.realestate.system.model.Agent;
import com.realestate.system.model.Appointment;
import com.realestate.system.model.Client;
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

@Controller
@RequestMapping("/appointments")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private AgentService agentService;

    private boolean canManage(HttpSession session) {
        String role = (String) session.getAttribute("role");
        return "ADMIN".equals(role) || "AGENT".equals(role);
    }

    @GetMapping("/list")
    public String listAppointments(Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        List<Appointment> appointments = appointmentService.getAllAppointments();
        model.addAttribute("appointments", appointments);
        model.addAttribute("clientNames", buildClientNameMap(appointments));
        model.addAttribute("agentNames", buildAgentNameMap(appointments));
        return "appointment-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "appointment-add";
    }

    @PostMapping("/add")
    public String addAppointment(@RequestParam String id, @RequestParam String clientId, @RequestParam String agentId, @RequestParam String date, @RequestParam String timeSlot, @RequestParam String status, @RequestParam String propertyDescription, @RequestParam String notes, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        Appointment appt = new Appointment(id, clientId, agentId, date, timeSlot, status, propertyDescription, notes);
        if (!appointmentService.addAppointment(appt)) {
            model.addAttribute("error", "Conflict detected or Duplicate ID.");
            model.addAttribute("clients", clientService.getAllClients());
            model.addAttribute("agents", agentService.getAllAgents());
            return "appointment-add";
        }

        redirectAttributes.addFlashAttribute("message", "Appointment booked for " + date + "!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/appointments/list";
    }

    @GetMapping("/search")
    public String showSearchForm(HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        return "appointment-search";
    }

    @GetMapping("/search/results")
    public String searchAppointment(@RequestParam String id, Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";

        Appointment appt = appointmentService.searchById(id);
        if (appt == null) {
            throw new ResourceNotFoundException("No appointment exists with the ID: " + id);
        }
        model.addAttribute("appointment", appt);
        model.addAttribute("searchedId", id);
        model.addAttribute("clientName", clientService.searchById(appt.getClientId()) != null ? clientService.searchById(appt.getClientId()).getName() : "Unknown");
        model.addAttribute("agentName", agentService.searchById(appt.getAgentId()) != null ? agentService.searchById(appt.getAgentId()).getName() : "Unknown");
        return "appointment-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session) {
        if (!canManage(session)) return "redirect:/appointments/list";

        Appointment appt = appointmentService.searchById(id);
        if (appt == null) {
            throw new ResourceNotFoundException("Cannot edit. Appointment not found with ID: " + id);
        }
        model.addAttribute("appointment", appt);
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "appointment-edit";
    }

    @PostMapping("/edit")
    public String updateAppointment(@RequestParam String id, @RequestParam String clientId, @RequestParam String agentId, @RequestParam String date, @RequestParam String timeSlot, @RequestParam String status, @RequestParam String propertyDescription, @RequestParam String notes, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canManage(session)) return "redirect:/appointments/list";
        appointmentService.updateAppointment(new Appointment(id, clientId, agentId, date, timeSlot, status, propertyDescription, notes));

        redirectAttributes.addFlashAttribute("message", "Appointment updated successfully.");
        redirectAttributes.addFlashAttribute("toastType", "info");
        return "redirect:/appointments/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteAppointment(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canManage(session)) return "redirect:/appointments/list";
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