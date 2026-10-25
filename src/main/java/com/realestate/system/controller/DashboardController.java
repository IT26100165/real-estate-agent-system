package com.realestate.system.controller;

import com.realestate.system.model.User;
import com.realestate.system.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @Autowired private AgentService agentService;
    @Autowired private ClientService clientService;
    @Autowired private PropertyService propertyService;
    @Autowired private AppointmentService appointmentService;
    @Autowired private ReviewService reviewService;

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        String role = user.getRole();
        String userId = user.getId();

        if ("ADMIN".equals(role)) {
            // Admin sees total system stats
            model.addAttribute("totalAgents", agentService.getAllAgents().size());
            model.addAttribute("totalClients", clientService.getAllClients().size());
            model.addAttribute("totalProperties", propertyService.getAllProperties().size());
            model.addAttribute("totalAppointments", appointmentService.getAllAppointments().size());
            return "dashboard-admin";

        } else if ("AGENT".equals(role)) {
            // Agent sees their specific stats
            model.addAttribute("myProperties", propertyService.getByAgentId(userId).size());
            model.addAttribute("myAppointments", appointmentService.getByAgentId(userId).size());
            model.addAttribute("myReviews", reviewService.getByAgentId(userId).size());

            // Get the agent's rating
            model.addAttribute("myRating", agentService.searchById(userId).getAverageRating());
            return "dashboard-agent";

        } else if ("CLIENT".equals(role)) {
            // Client sees their specific stats
            model.addAttribute("myAppointments", appointmentService.getByClientId(userId).size());
            model.addAttribute("myReviews", reviewService.getByClientId(userId).size());
            return "dashboard-client";
        }

        return "redirect:/login";
    }
}