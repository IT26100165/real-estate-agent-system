package com.realestate.system.controller;

import com.realestate.system.exception.ResourceNotFoundException;
import com.realestate.system.model.Agent;
import com.realestate.system.model.Property;
import com.realestate.system.model.User;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.PropertyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/properties")
public class PropertyController {

    @Autowired
    private PropertyService propertyService;
    @Autowired
    private AgentService agentService;

    private boolean canAdd(HttpSession session) {
        String role = (String) session.getAttribute("role");
        if ("ADMIN".equals(role)) return "FULL_ACCESS".equals(session.getAttribute("adminPermissions"));
        return "AGENT".equals(role);
    }

    private boolean canModifySpecificProperty(HttpSession session, Property property) {
        String role = (String) session.getAttribute("role");
        if ("ADMIN".equals(role)) return "FULL_ACCESS".equals(session.getAttribute("adminPermissions"));
        if ("AGENT".equals(role)) {
            User currentUser = (User) session.getAttribute("user");
            return currentUser != null && currentUser.getId().equals(property.getListingAgentId());
        }
        return false;
    }

    @GetMapping("/list")
    public String listProperties(Model model, HttpSession session) {
        List<Property> properties = propertyService.getAllProperties();

        // Data Isolation: If Agent, only show their properties
        User user = (User) session.getAttribute("user");
        if (user != null && "AGENT".equals(user.getRole())) {
            properties = properties.stream()
                    .filter(p -> p.getListingAgentId().equals(user.getId()))
                    .collect(Collectors.toList());
        }

        model.addAttribute("properties", properties);
        model.addAttribute("agentNames", buildAgentNameMap(properties));
        return "property-list";
    }

    // ... (Keep the rest of the methods exactly the same as the previous step)

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        if (!canAdd(session)) return "redirect:/properties/list";
        User user = (User) session.getAttribute("user");
        if ("AGENT".equals(user.getRole())) {
            model.addAttribute("agents", List.of(agentService.searchById(user.getId())));
        } else {
            model.addAttribute("agents", agentService.getAllAgents());
        }
        return "property-add";
    }

    @PostMapping("/add")
    public String addProperty(@RequestParam String id, @RequestParam String title, @RequestParam String location, @RequestParam double price, @RequestParam String propertyType, @RequestParam int bedrooms, @RequestParam int bathrooms, @RequestParam String description, @RequestParam String listingAgentId, @RequestParam String availabilityStatus, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!canAdd(session)) return "redirect:/properties/list";
        propertyService.addProperty(new Property(id, title, location, price, propertyType, bedrooms, bathrooms, description, listingAgentId, LocalDate.now().toString(), availabilityStatus));
        redirectAttributes.addFlashAttribute("message", "Property '" + title + "' listed successfully!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/properties/list";
    }

    @GetMapping("/search")
    public String showSearchForm() { return "property-search"; }

    @GetMapping("/search/results")
    public String searchProperty(@RequestParam String id, Model model) {
        Property property = propertyService.searchById(id);
        if (property == null) throw new ResourceNotFoundException("No property exists with the ID: " + id);
        model.addAttribute("property", property);
        model.addAttribute("searchedId", id);
        Agent agent = agentService.searchById(property.getListingAgentId());
        model.addAttribute("agentName", agent != null ? agent.getName() : "Unknown");
        return "property-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        Property property = propertyService.searchById(id);
        if (property == null) throw new ResourceNotFoundException("Cannot edit. Property not found with ID: " + id);
        if (!canModifySpecificProperty(session, property)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: You can only edit your own properties.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/properties/list";
        }
        model.addAttribute("property", property);
        User user = (User) session.getAttribute("user");
        if ("AGENT".equals(user.getRole())) {
            model.addAttribute("agents", List.of(agentService.searchById(user.getId())));
        } else {
            model.addAttribute("agents", agentService.getAllAgents());
        }
        return "property-edit";
    }

    @PostMapping("/edit")
    public String updateProperty(@RequestParam String id, @RequestParam String title, @RequestParam String location, @RequestParam double price, @RequestParam String propertyType, @RequestParam int bedrooms, @RequestParam int bathrooms, @RequestParam String description, @RequestParam String listingAgentId, @RequestParam String listedDate, @RequestParam String availabilityStatus, HttpSession session, RedirectAttributes redirectAttributes) {
        Property property = propertyService.searchById(id);
        if (property == null) throw new ResourceNotFoundException("Property not found.");
        if (!canModifySpecificProperty(session, property)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: You can only edit your own properties.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/properties/list";
        }
        propertyService.updateProperty(new Property(id, title, location, price, propertyType, bedrooms, bathrooms, description, listingAgentId, listedDate, availabilityStatus));
        redirectAttributes.addFlashAttribute("message", "Property details updated.");
        redirectAttributes.addFlashAttribute("toastType", "info");
        return "redirect:/properties/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteProperty(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        Property property = propertyService.searchById(id);
        if (property == null) throw new ResourceNotFoundException("Property not found.");
        if (!canModifySpecificProperty(session, property)) {
            redirectAttributes.addFlashAttribute("message", "Access Denied: You can only delete your own properties.");
            redirectAttributes.addFlashAttribute("toastType", "error");
            return "redirect:/properties/list";
        }
        propertyService.deleteProperty(id);
        redirectAttributes.addFlashAttribute("message", "Property deleted successfully.");
        redirectAttributes.addFlashAttribute("toastType", "error");
        return "redirect:/properties/list";
    }

    private Map<String, String> buildAgentNameMap(List<Property> properties) {
        Map<String, String> map = new HashMap<>();
        for (Property p : properties) {
            if (!map.containsKey(p.getListingAgentId())) {
                Agent ag = agentService.searchById(p.getListingAgentId());
                map.put(p.getListingAgentId(), ag != null ? ag.getName() : "Unknown");
            }
        }
        return map;
    }
}