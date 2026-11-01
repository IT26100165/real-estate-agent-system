package com.realestate.system.controller;

import com.realestate.system.model.Admin;
import com.realestate.system.model.Agent;
import com.realestate.system.model.Client;
import com.realestate.system.model.User;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ProfileController {

    @Autowired
    private AgentService agentService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private AdminService adminService;

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        // Fetch the latest data from the service layer
        if ("AGENT".equals(user.getRole())) {
            model.addAttribute("profile", agentService.searchById(user.getId()));
        } else if ("CLIENT".equals(user.getRole())) {
            model.addAttribute("profile", clientService.searchById(user.getId()));
        } else if ("ADMIN".equals(user.getRole())) {
            model.addAttribute("profile", adminService.searchById(user.getId()));
        }
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(@RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String password,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        // Update the specific user type
        if ("AGENT".equals(user.getRole())) {
            Agent agent = agentService.searchById(user.getId());
            agent.setName(name); agent.setEmail(email); agent.setPassword(password);
            agentService.updateAgent(agent);
        } else if ("CLIENT".equals(user.getRole())) {
            Client client = clientService.searchById(user.getId());
            client.setName(name); client.setEmail(email); client.setPassword(password);
            clientService.updateClient(client);
        } else if ("ADMIN".equals(user.getRole())) {
            Admin admin = adminService.searchById(user.getId());
            admin.setName(name); admin.setEmail(email); admin.setPassword(password);
            adminService.updateAdmin(admin);
        }

        // Update the session so the Navbar name changes immediately
        user.setName(name);
        session.setAttribute("user", user);
        session.setAttribute("userName", name);

        redirectAttributes.addFlashAttribute("message", "Profile updated successfully!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/profile";
    }
}