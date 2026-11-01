package com.realestate.system.controller;

import com.realestate.system.exception.ResourceNotFoundException;
import com.realestate.system.model.Admin;
import com.realestate.system.service.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admins")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // Helper method to check if they are full access admin
    private boolean isFullAccess(HttpSession session) {
        return "FULL_ACCESS".equals(session.getAttribute("adminPermissions"));
    }

    @GetMapping("/list")
    public String listAdmins(Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        model.addAttribute("admins", adminService.getAllAdmins());
        return "admin-list";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isFullAccess(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: Read-Only Admins cannot add accounts.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/admins/list";
        }
        return "admin-add";
    }

    @PostMapping("/add")
    public String addAdmin(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String permissions, @RequestParam String activityLog, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isFullAccess(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/admins/list";
        }

        if (!adminService.addAdmin(new Admin(id, name, email, password, permissions, "Never", activityLog))) {
            model.addAttribute("error", "Duplicate Admin ID.");
            return "admin-add";
        }

        redirectAttributes.addFlashAttribute("message", "New Administrator added successfully.");
        redirectAttributes.addFlashAttribute("toastType", "success");
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

        Admin admin = adminService.searchById(id);
        if (admin == null) {
            throw new ResourceNotFoundException("No admin exists with the ID: " + id);
        }
        model.addAttribute("admin", admin);
        model.addAttribute("searchedId", id);
        return "admin-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isFullAccess(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: Read-Only Admins cannot edit accounts.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/admins/list";
        }

        Admin admin = adminService.searchById(id);
        if (admin == null) {
            throw new ResourceNotFoundException("Cannot edit. Admin not found with ID: " + id);
        }
        model.addAttribute("admin", admin);
        return "admin-edit";
    }

    @PostMapping("/edit")
    public String updateAdmin(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String permissions, @RequestParam String lastLogin, @RequestParam String activityLog, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isFullAccess(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/admins/list";
        }

        adminService.updateAdmin(new Admin(id, name, email, password, permissions, lastLogin, activityLog));

        redirectAttributes.addFlashAttribute("message", "Admin permissions updated.");
        redirectAttributes.addFlashAttribute("toastType", "info");
        return "redirect:/admins/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isFullAccess(session)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: Read-Only Admins cannot delete accounts.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/admins/list";
        }

        adminService.deleteAdmin(id);

        redirectAttributes.addFlashAttribute("message", "Admin account deleted.");
        redirectAttributes.addFlashAttribute("toastType", "error");
        return "redirect:/admins/list";
    }
}