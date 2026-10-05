package com.realestate.system.controller;

import com.realestate.system.model.Agent;
import com.realestate.system.service.AgentService;
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

    // Show login form
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    // Process login
    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String password,
                               HttpSession session,
                               Model model) {
        Agent agent = agentService.authenticate(email, password);

        if (agent != null) {
            session.setAttribute("user", agent);
            session.setAttribute("userName", agent.getName());
            session.setAttribute("role", agent.getRole());
            return "redirect:/agents/list";
        }

        model.addAttribute("error", "Invalid email or password");
        return "login";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}