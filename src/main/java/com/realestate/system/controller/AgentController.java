package com.realestate.system.controller;

import com.realestate.system.model.Agent;
import com.realestate.system.service.AgentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/agents")
public class AgentController {

    @Autowired
    private AgentService agentService;

    @GetMapping("/list")
    public String listAgents(Model model) {
        model.addAttribute("agents", agentService.getAllAgentsSortedByRating());
        return "agent-list";
    }

    @GetMapping("/add")
    public String showAddForm() {
        return "agent-add";
    }

    @PostMapping("/add")
    public String addAgent(@RequestParam String id,
                           @RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String specialization,
                           @RequestParam String contactNumber) {
        Agent agent = new Agent(id, name, email, password, specialization, contactNumber);
        agentService.addAgent(agent);
        return "redirect:/agents/list";
    }

    @GetMapping("/search")
    public String showSearchForm() {
        return "agent-search";
    }

    @GetMapping("/search/results")
    public String searchAgent(@RequestParam String id, Model model) {
        Agent agent = agentService.searchById(id);
        model.addAttribute("agent", agent);
        model.addAttribute("searchedId", id);
        return "agent-search";
    }

    @GetMapping("/delete/{id}")
    public String deleteAgent(@PathVariable String id) {
        agentService.deleteAgent(id);
        return "redirect:/agents/list";
    }
}