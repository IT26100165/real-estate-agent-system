package com.realestate.system.controller;

import com.realestate.system.exception.ResourceNotFoundException;
import com.realestate.system.model.Appointment;
import com.realestate.system.model.Client;
import com.realestate.system.model.Review;
import com.realestate.system.service.AppointmentService;
import com.realestate.system.service.ClientService;
import com.realestate.system.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/clients")
public class ClientController {

    @Autowired
    private ClientService clientService;
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
        return "client-register";
    }

    @PostMapping("/register")
    public String registerClient(@RequestParam String id, @RequestParam String name, @RequestParam String email,
                                 @RequestParam String password, @RequestParam String phoneNumber,
                                 @RequestParam String address, @RequestParam String propertyPreference,
                                 RedirectAttributes redirectAttributes) {

        if (clientService.searchByEmail(email) != null) {
            redirectAttributes.addFlashAttribute("message", "Email already registered. Please login.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/clients/register";
        }

        if (clientService.searchById(id) != null) {
            redirectAttributes.addFlashAttribute("message", "Client ID is already taken. Please choose another.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/clients/register";
        }

        clientService.addClient(new Client(id, name, email, password, phoneNumber, address, propertyPreference, LocalDate.now().toString()));

        redirectAttributes.addFlashAttribute("message", "Registration successful! Please login.");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/login";
    }

    // ==========================================
    // ADMIN ROUTES (Login required)
    // ==========================================

    @GetMapping("/list")
    public String listClients(Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        model.addAttribute("clients", clientService.getAllClients());
        return "client-list";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session) {
        if (!canModify(session)) return "redirect:/dashboard";
        return "client-add";
    }

    @PostMapping("/add")
    public String addClient(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String phoneNumber, @RequestParam String address, @RequestParam String propertyPreference, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) return "redirect:/dashboard";

        if (clientService.searchById(id) != null) {
            redirectAttributes.addFlashAttribute("message", "Error: A client with this ID already exists.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/clients/list";
        }

        clientService.addClient(new Client(id, name, email, password, phoneNumber, address, propertyPreference, LocalDate.now().toString()));
        redirectAttributes.addFlashAttribute("message", "Client " + name + " registered successfully!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/clients/list";
    }

    @GetMapping("/search")
    public String showSearchForm(HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        return "client-search";
    }

    @GetMapping("/search/results")
    public String searchClient(@RequestParam String id, Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/dashboard";
        Client client = clientService.searchById(id);
        if (client == null) throw new ResourceNotFoundException("No client exists with the ID: " + id);
        model.addAttribute("client", client);
        model.addAttribute("searchedId", id);
        return "client-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session) {
        if (!canModify(session)) return "redirect:/dashboard";
        Client client = clientService.searchById(id);
        if (client == null) throw new ResourceNotFoundException("Cannot edit. Client not found with ID: " + id);
        model.addAttribute("client", client);
        return "client-edit";
    }

    @PostMapping("/edit")
    public String updateClient(@RequestParam String id, @RequestParam String name, @RequestParam String email, @RequestParam String password, @RequestParam String phoneNumber, @RequestParam String address, @RequestParam String propertyPreference, @RequestParam String registrationDate, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) return "redirect:/dashboard";
        clientService.updateClient(new Client(id, name, email, password, phoneNumber, address, propertyPreference, registrationDate));
        redirectAttributes.addFlashAttribute("message", "Client profile updated successfully!");
        redirectAttributes.addFlashAttribute("toastType", "info");
        return "redirect:/clients/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteClient(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canModify(session)) return "redirect:/dashboard";

        // --- CASCADE DELETE START ---
        // Find and delete associated appointments
        List<String> appointmentIdsToDelete = new ArrayList<>();
        for (Appointment a : appointmentService.getAllAppointments()) {
            if (a.getClientId().equals(id)) appointmentIdsToDelete.add(a.getId());
        }
        for (String aId : appointmentIdsToDelete) {
            appointmentService.deleteAppointment(aId);
        }

        // Find and delete associated reviews
        List<String> reviewIdsToDelete = new ArrayList<>();
        for (Review r : reviewService.getAllReviews()) {
            if (r.getClientId().equals(id)) reviewIdsToDelete.add(r.getId());
        }
        for (String rId : reviewIdsToDelete) {
            reviewService.deleteReview(rId);
        }
        // --- CASCADE DELETE END ---

        clientService.deleteClient(id);
        redirectAttributes.addFlashAttribute("message", "Client and all associated records deleted successfully.");
        redirectAttributes.addFlashAttribute("toastType", "error");
        return "redirect:/clients/list";
    }
}