package com.realestate.system.controller;

import com.realestate.system.model.Admin;
import com.realestate.system.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admins")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // 1. LIST
    @GetMapping("/list")
    public String listAdmins(Model model) {
        model.addAttribute("admins", adminService.getAllAdmins());
        return "admin-list";
    }

    // 2. ADD PAGE
    @GetMapping("/add")
    public String showAddForm() {
        return "admin-add";
    }

    // 3. ADD - process
    @PostMapping("/add")
    public String addAdmin(@RequestParam String id,
                           @RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String permissions,
                           @RequestParam String activityLog,
                           Model model) {
        Admin admin = new Admin(id, name, email, password,
                permissions, "Never", activityLog);

        boolean success = adminService.addAdmin(admin);
        if (!success) {
            model.addAttribute("error", "Duplicate Admin ID detected.");
            return "admin-add";
        }
        return "redirect:/admins/list";
    }

    // 4. SEARCH PAGE
    @GetMapping("/search")
    public String showSearchForm() {
        return "admin-search";
    }

    // 5. SEARCH - results
    @GetMapping("/search/results")
    public String searchAdmin(@RequestParam String id, Model model) {
        Admin admin = adminService.searchById(id);
        model.addAttribute("admin", admin);
        model.addAttribute("searchedId", id);
        return "admin-search";
    }

    // 6. EDIT PAGE
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Admin admin = adminService.searchById(id);
        if (admin == null) {
            return "redirect:/admins/list";
        }
        model.addAttribute("admin", admin);
        return "admin-edit";
    }

    // 7. EDIT - process
    @PostMapping("/edit")
    public String updateAdmin(@RequestParam String id,
                              @RequestParam String name,
                              @RequestParam String email,
                              @RequestParam String password,
                              @RequestParam String permissions,
                              @RequestParam String lastLogin,
                              @RequestParam String activityLog) {
        Admin admin = new Admin(id, name, email, password,
                permissions, lastLogin, activityLog);
        adminService.updateAdmin(admin);
        return "redirect:/admins/list";
    }

    // 8. DELETE
    @GetMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable String id) {
        adminService.deleteAdmin(id);
        return "redirect:/admins/list";
    }
}