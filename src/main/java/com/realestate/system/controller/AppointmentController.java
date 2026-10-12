package com.realestate.system.controller;

import com.realestate.system.model.Agent;
import com.realestate.system.model.Appointment;
import com.realestate.system.model.Client;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.AppointmentService;
import com.realestate.system.service.ClientService;
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

    // 1. LIST - with FK name resolution
    @GetMapping("/list")
    public String listAppointments(Model model) {
        List<Appointment> appointments = appointmentService.getAllAppointments();
        model.addAttribute("appointments", appointments);
        model.addAttribute("clientNames", buildClientNameMap(appointments));
        model.addAttribute("agentNames", buildAgentNameMap(appointments));
        return "appointment-list";
    }

    // 2. ADD PAGE - load dropdowns
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "appointment-add";
    }

    // 3. ADD - process form
    @PostMapping("/add")
    public String addAppointment(@RequestParam String id,
                                 @RequestParam String clientId,
                                 @RequestParam String agentId,
                                 @RequestParam String date,
                                 @RequestParam String timeSlot,
                                 @RequestParam String status,
                                 @RequestParam String propertyDescription,
                                 @RequestParam String notes,
                                 Model model) {
        Appointment appt = new Appointment(id, clientId, agentId, date,
                timeSlot, status, propertyDescription, notes);

        boolean success = appointmentService.addAppointment(appt);
        if (!success) {
            model.addAttribute("error", "Duplicate ID or scheduling conflict detected.");
            model.addAttribute("clients", clientService.getAllClients());
            model.addAttribute("agents", agentService.getAllAgents());
            return "appointment-add";
        }
        return "redirect:/appointments/list";
    }

    // 4. SEARCH PAGE
    @GetMapping("/search")
    public String showSearchForm() {
        return "appointment-search";
    }

    // 5. SEARCH - results
    @GetMapping("/search/results")
    public String searchAppointment(@RequestParam String id, Model model) {
        Appointment appt = appointmentService.searchById(id);
        model.addAttribute("appointment", appt);
        model.addAttribute("searchedId", id);

        if (appt != null) {
            Client client = clientService.searchById(appt.getClientId());
            Agent agent = agentService.searchById(appt.getAgentId());
            model.addAttribute("clientName", client != null ? client.getName() : "Unknown");
            model.addAttribute("agentName", agent != null ? agent.getName() : "Unknown");
        }
        return "appointment-search";
    }

    // 6. EDIT PAGE
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Appointment appt = appointmentService.searchById(id);
        if (appt == null) {
            return "redirect:/appointments/list";
        }
        model.addAttribute("appointment", appt);
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "appointment-edit";
    }

    // 7. EDIT - process form
    @PostMapping("/edit")
    public String updateAppointment(@RequestParam String id,
                                    @RequestParam String clientId,
                                    @RequestParam String agentId,
                                    @RequestParam String date,
                                    @RequestParam String timeSlot,
                                    @RequestParam String status,
                                    @RequestParam String propertyDescription,
                                    @RequestParam String notes) {
        Appointment appt = new Appointment(id, clientId, agentId, date,
                timeSlot, status, propertyDescription, notes);
        appointmentService.updateAppointment(appt);
        return "redirect:/appointments/list";
    }

    // 8. DELETE
    @GetMapping("/delete/{id}")
    public String deleteAppointment(@PathVariable String id) {
        appointmentService.deleteAppointment(id);
        return "redirect:/appointments/list";
    }

    // ===== Helper Methods for FK Resolution =====
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