package com.realestate.system.controller;

import com.realestate.system.exception.ResourceNotFoundException;
import com.realestate.system.model.Agent;
import com.realestate.system.model.Appointment;
import com.realestate.system.model.Property;
import com.realestate.system.model.Review;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.AppointmentService;
import com.realestate.system.service.PropertyService;
import com.realestate.system.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/agents")
public class AgentController {

    @Autowired
    private AgentService agentService;
    @Autowired
    private PropertyService propertyService;
    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private ReviewService reviewService;

    private boolean canModify(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("role"))
                && "FULL_ACCESS".equals(session.getAttribute("adminPermissions"));
    }

    // ==========================================
    // PUBLIC ROUTES (No login required)
    // ==========================================

    @GetMapping("/register")
    public String showRegisterForm() {
        return "agent-register";
    }

    @PostMapping("/register")
    public String registerAgent(@RequestParam String id, @RequestParam String name, @RequestParam String email,
                                @RequestParam String password, @RequestParam String specialization,
                                @RequestParam String contactNumber, RedirectAttributes redirectAttributes) {

        boolean emailExists = agentService.getAllAgents().stream().anyMatch(a -> a.getEmail().equalsIgnoreCase(email));
        if (emailExists) {
            redirectAttributes.addFlashAttribute("message", "Email already registered. Please login.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/agents/register";
        }

        if (agentService.searchById(id) != null) {
            redirectAttributes.addFlashAttribute("message", "Agent ID is already taken. Please choose another.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/agents/register";
        }

        Agent agent = new Agent(id, name, email, password, specialization, contactNumber);
        agentService.addAgent(agent);

        redirectAttributes.addFlashAttribute("message", "Agent registration successful! Please login.");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/login";
    }

    // ==========================================
    // ADMIN/LIST ROUTES
    // ==========================================

    @GetMapping("/list")
    public String listAgents(Model model, HttpSession session) {
        if ("AGENT".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        model.addAttribute("agents", agentService.getAllAgentsSortedByRating());
        return "agent-list";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: Read-Only Admins cannot add agents.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/agents/list";
        }
        return "agent-add";
    }

    @PostMapping("/add")
    public String addAgent(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String specialization, @RequestParam String contactNumber, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) return "redirect:/agents/list";

        if (agentService.searchById(id) != null) {
            redirectAttributes.addFlashAttribute("message", "Error: An agent with this ID already exists.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/agents/list";
        }

        Agent agent = new Agent(id, name, email, password, specialization, contactNumber);
        agentService.addAgent(agent);
        redirectAttributes.addFlashAttribute("message", "Agent " + name + " added successfully!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/agents/list";
    }

    @GetMapping("/search")
    public String showSearchForm(HttpSession session) {
        if ("AGENT".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        return "agent-search";
    }

    @GetMapping("/search/results")
    public String searchAgent(@RequestParam String id, Model model, HttpSession session) {
        if ("AGENT".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        Agent agent = agentService.searchById(id);
        if (agent == null) throw new ResourceNotFoundException("No agent exists with the ID: " + id);
        model.addAttribute("agent", agent);
        model.addAttribute("searchedId", id);
        return "agent-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) return "redirect:/agents/list";
        Agent agent = agentService.searchById(id);
        if (agent == null) throw new ResourceNotFoundException("Cannot edit. Agent not found with ID: " + id);
        model.addAttribute("agent", agent);
        return "agent-edit";
    }

    @PostMapping("/edit")
    public String updateAgent(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String specialization, @RequestParam String contactNumber, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) return "redirect:/agents/list";
        Agent agent = new Agent(id, name, email, password, specialization, contactNumber);
        agentService.updateAgent(agent);
        redirectAttributes.addFlashAttribute("message", "Agent updated successfully!");
        redirectAttributes.addFlashAttribute("toastType", "info");
        return "redirect:/agents/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteAgent(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) return "redirect:/agents/list";

        // --- CASCADE DELETE START ---
        // Find and delete associated properties
        List<String> propertyIdsToDelete = new ArrayList<>();
        for (Property p : propertyService.getAllProperties()) {
            if (p.getListingAgentId().equals(id)) propertyIdsToDelete.add(p.getId());
        }
        for (String pId : propertyIdsToDelete) {
            propertyService.deleteProperty(pId);
        }

        // Find and delete associated appointments
        List<String> appointmentIdsToDelete = new ArrayList<>();
        for (Appointment a : appointmentService.getAllAppointments()) {
            if (a.getAgentId().equals(id)) appointmentIdsToDelete.add(a.getId());
        }
        for (String aId : appointmentIdsToDelete) {
            appointmentService.deleteAppointment(aId);
        }

        // Find and delete associated reviews
        List<String> reviewIdsToDelete = new ArrayList<>();
        for (Review r : reviewService.getAllReviews()) {
            if (r.getAgentId().equals(id)) reviewIdsToDelete.add(r.getId());
        }
        for (String rId : reviewIdsToDelete) {
            reviewService.deleteReview(rId);
        }
        // --- CASCADE DELETE END ---

        agentService.deleteAgent(id);
        redirectAttributes.addFlashAttribute("message", "Agent and all associated records deleted successfully.");
        redirectAttributes.addFlashAttribute("toastType", "error");
        return "redirect:/agents/list";
    }
}