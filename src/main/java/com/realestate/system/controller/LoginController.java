package com.realestate.system.controller;

import com.realestate.system.model.Admin;
import com.realestate.system.model.Agent;
import com.realestate.system.model.Client;
import com.realestate.system.service.AdminService;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.ClientService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private AgentService agentService;

    @Autowired
    private ClientService clientService;

    @Autowired
    private AdminService adminService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String password,
                               HttpSession session,
                               Model model) {

        // Try Agent login
        Agent agent = agentService.authenticate(email, password);
        if (agent != null) {
            session.setAttribute("user", agent);
            session.setAttribute("userName", agent.getName());
            session.setAttribute("role", agent.getRole());
            return "redirect:/agents/list";
        }

        // Try Client login
        Client client = clientService.authenticate(email, password);
        if (client != null) {
            session.setAttribute("user", client);
            session.setAttribute("userName", client.getName());
            session.setAttribute("role", client.getRole());
            return "redirect:/clients/list";
        }

        // Try Admin login
        Admin admin = adminService.authenticate(email, password);
        if (admin != null) {
            session.setAttribute("user", admin);
            session.setAttribute("userName", admin.getName());
            session.setAttribute("role", admin.getRole());
            return "redirect:/admins/list";
        }

        model.addAttribute("error", "Invalid email or password");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}