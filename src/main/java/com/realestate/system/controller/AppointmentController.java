package com.realestate.system.controller;

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
    public String addAppointment(@RequestParam String id, @RequestParam String clientId, @RequestParam String agentId, @RequestParam String date, @RequestParam String timeSlot, @RequestParam String status, @RequestParam String propertyDescription, @RequestParam String notes, Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        if (!appointmentService.addAppointment(new Appointment(id, clientId, agentId, date, timeSlot, status, propertyDescription, notes))) {
            model.addAttribute("error", "Conflict detected.");
            model.addAttribute("clients", clientService.getAllClients());
            model.addAttribute("agents", agentService.getAllAgents());
            return "appointment-add";
        }
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
        model.addAttribute("appointment", appt);
        model.addAttribute("searchedId", id);
        if (appt != null) {
            model.addAttribute("clientName", clientService.searchById(appt.getClientId()) != null ? clientService.searchById(appt.getClientId()).getName() : "Unknown");
            model.addAttribute("agentName", agentService.searchById(appt.getAgentId()) != null ? agentService.searchById(appt.getAgentId()).getName() : "Unknown");
        }
        return "appointment-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session) {
        if (!canManage(session)) return "redirect:/appointments/list";
        Appointment appt = appointmentService.searchById(id);
        if (appt == null) return "redirect:/appointments/list";
        model.addAttribute("appointment", appt);
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "appointment-edit";
    }

    @PostMapping("/edit")
    public String updateAppointment(@RequestParam String id, @RequestParam String clientId, @RequestParam String agentId, @RequestParam String date, @RequestParam String timeSlot, @RequestParam String status, @RequestParam String propertyDescription, @RequestParam String notes, HttpSession session) {
        if (!canManage(session)) return "redirect:/appointments/list";
        appointmentService.updateAppointment(new Appointment(id, clientId, agentId, date, timeSlot, status, propertyDescription, notes));
        return "redirect:/appointments/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteAppointment(@PathVariable String id, HttpSession session) {
        if (!canManage(session)) return "redirect:/appointments/list";
        appointmentService.deleteAppointment(id);
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