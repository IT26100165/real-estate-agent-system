package com.realestate.system.controller;

import com.realestate.system.exception.ResourceNotFoundException;
import com.realestate.system.model.Agent;
import com.realestate.system.service.AgentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/agents")
public class AgentController {

    @Autowired
    private AgentService agentService;

    // Helper method to ensure only FULL_ACCESS admins can modify
    private boolean canModify(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("role"))
                && "FULL_ACCESS".equals(session.getAttribute("adminPermissions"));
    }

    @GetMapping("/list")
    public String listAgents(Model model) {
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
        Agent agent = new Agent(id, name, email, password, specialization, contactNumber);
        agentService.addAgent(agent);
        redirectAttributes.addFlashAttribute("message", "Agent " + name + " added successfully!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/agents/list";
    }

    @GetMapping("/search")
    public String showSearchForm() {
        return "agent-search";
    }

    @GetMapping("/search/results")
    public String searchAgent(@RequestParam String id, Model model) {
        Agent agent = agentService.searchById(id);
        if (agent == null) throw new ResourceNotFoundException("No agent exists with the ID: " + id);
        model.addAttribute("agent", agent);
        model.addAttribute("searchedId", id);
        return "agent-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: Read-Only Admins cannot edit agents.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/agents/list";
        }
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
        if (!canModify(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: Read-Only Admins cannot delete agents.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/agents/list";
        }
        agentService.deleteAgent(id);
        redirectAttributes.addFlashAttribute("message", "Agent deleted successfully.");
        redirectAttributes.addFlashAttribute("toastType", "error");
        return "redirect:/agents/list";
    }
}