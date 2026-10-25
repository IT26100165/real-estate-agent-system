package com.realestate.system.controller;

import com.realestate.system.model.Admin;
import com.realestate.system.service.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admins")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @GetMapping("/list")
    public String listAdmins(Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        model.addAttribute("admins", adminService.getAllAdmins());
        return "admin-list";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        return "admin-add";
    }

    @PostMapping("/add")
    public String addAdmin(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String permissions, @RequestParam String activityLog, Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        if (!adminService.addAdmin(new Admin(id, name, email, password, permissions, "Never", activityLog))) {
            model.addAttribute("error", "Duplicate Admin ID.");
            return "admin-add";
        }
        return "redirect:/admins/list";
    }

    @GetMapping("/search")
    public String showSearchForm(HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        return "admin-search";
    }

    @GetMapping("/search/results")
    public String searchAdmin(@RequestParam String id, Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        model.addAttribute("admin", adminService.searchById(id));
        model.addAttribute("searchedId", id);
        return "admin-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        Admin admin = adminService.searchById(id);
        if (admin == null) return "redirect:/admins/list";
        model.addAttribute("admin", admin);
        return "admin-edit";
    }

    @PostMapping("/edit")
    public String updateAdmin(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String permissions, @RequestParam String lastLogin, @RequestParam String activityLog, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        adminService.updateAdmin(new Admin(id, name, email, password, permissions, lastLogin, activityLog));
        return "redirect:/admins/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable String id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        adminService.deleteAdmin(id);
        return "redirect:/admins/list";
    }
}