package com.realestate.system.controller;

import com.realestate.system.model.Agent;
import com.realestate.system.service.AgentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/agents")
public class AgentController {

    @Autowired
    private AgentService agentService;

    // 1. LIST - Everyone can view
    @GetMapping("/list")
    public String listAgents(Model model) {
        model.addAttribute("agents", agentService.getAllAgentsSortedByRating());
        return "agent-list";
    }

    // 2. ADD PAGE - ONLY ADMIN
    @GetMapping("/add")
    public String showAddForm(HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/agents/list";
        }
        return "agent-add";
    }

    // 3. ADD - ONLY ADMIN
    @PostMapping("/add")
    public String addAgent(@RequestParam String id, @RequestParam String name, @RequestParam String email,
                           @RequestParam String password, @RequestParam String specialization,
                           @RequestParam String contactNumber, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/agents/list";
        }
        Agent agent = new Agent(id, name, email, password, specialization, contactNumber);
        agentService.addAgent(agent);
        return "redirect:/agents/list";
    }

    // 4. SEARCH PAGE
    @GetMapping("/search")
    public String showSearchForm() {
        return "agent-search";
    }

    // 5. SEARCH - results
    @GetMapping("/search/results")
    public String searchAgent(@RequestParam String id, Model model) {
        Agent agent = agentService.searchById(id);
        model.addAttribute("agent", agent);
        model.addAttribute("searchedId", id);
        return "agent-search";
    }

    // 6. EDIT PAGE - ONLY ADMIN
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/agents/list";
        }
        Agent agent = agentService.searchById(id);
        if (agent == null) {
            return "redirect:/agents/list";
        }
        model.addAttribute("agent", agent);
        return "agent-edit";
    }

    // 7. EDIT - ONLY ADMIN
    @PostMapping("/edit")
    public String updateAgent(@RequestParam String id, @RequestParam String name, @RequestParam String email,
                              @RequestParam String password, @RequestParam String specialization,
                              @RequestParam String contactNumber, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/agents/list";
        }
        Agent agent = new Agent(id, name, email, password, specialization, contactNumber);
        agentService.updateAgent(agent);
        return "redirect:/agents/list";
    }

    // 8. DELETE - ONLY ADMIN
    @GetMapping("/delete/{id}")
    public String deleteAgent(@PathVariable String id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/agents/list";
        }
        agentService.deleteAgent(id);
        return "redirect:/agents/list";
    }
}