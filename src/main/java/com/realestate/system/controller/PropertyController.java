package com.realestate.system.controller;

import com.realestate.system.model.Agent;
import com.realestate.system.model.Property;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/properties")
public class PropertyController {

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private AgentService agentService;

    // 1. LIST
    @GetMapping("/list")
    public String listProperties(Model model) {
        List<Property> properties = propertyService.getAllProperties();
        model.addAttribute("properties", properties);
        model.addAttribute("agentNames", buildAgentNameMap(properties));
        return "property-list";
    }

    // 2. ADD PAGE
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("agents", agentService.getAllAgents());
        return "property-add";
    }

    // 3. ADD - process
    @PostMapping("/add")
    public String addProperty(@RequestParam String id,
                              @RequestParam String title,
                              @RequestParam String location,
                              @RequestParam double price,
                              @RequestParam String propertyType,
                              @RequestParam int bedrooms,
                              @RequestParam int bathrooms,
                              @RequestParam String description,
                              @RequestParam String listingAgentId,
                              @RequestParam String availabilityStatus,
                              Model model) {
        String today = LocalDate.now().toString();
        Property property = new Property(id, title, location, price,
                propertyType, bedrooms, bathrooms, description,
                listingAgentId, today, availabilityStatus);

        boolean success = propertyService.addProperty(property);
        if (!success) {
            model.addAttribute("error", "Duplicate Property ID detected.");
            model.addAttribute("agents", agentService.getAllAgents());
            return "property-add";
        }
        return "redirect:/properties/list";
    }

    // 4. SEARCH PAGE
    @GetMapping("/search")
    public String showSearchForm() {
        return "property-search";
    }

    // 5. SEARCH - results
    @GetMapping("/search/results")
    public String searchProperty(@RequestParam String id, Model model) {
        Property property = propertyService.searchById(id);
        model.addAttribute("property", property);
        model.addAttribute("searchedId", id);

        if (property != null) {
            Agent agent = agentService.searchById(property.getListingAgentId());
            model.addAttribute("agentName", agent != null ? agent.getName() : "Unknown");
        }
        return "property-search";
    }

    // 6. EDIT PAGE
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Property property = propertyService.searchById(id);
        if (property == null) {
            return "redirect:/properties/list";
        }
        model.addAttribute("property", property);
        model.addAttribute("agents", agentService.getAllAgents());
        return "property-edit";
    }

    // 7. EDIT - process
    @PostMapping("/edit")
    public String updateProperty(@RequestParam String id,
                                 @RequestParam String title,
                                 @RequestParam String location,
                                 @RequestParam double price,
                                 @RequestParam String propertyType,
                                 @RequestParam int bedrooms,
                                 @RequestParam int bathrooms,
                                 @RequestParam String description,
                                 @RequestParam String listingAgentId,
                                 @RequestParam String listedDate,
                                 @RequestParam String availabilityStatus) {
        Property property = new Property(id, title, location, price,
                propertyType, bedrooms, bathrooms, description,
                listingAgentId, listedDate, availabilityStatus);
        propertyService.updateProperty(property);
        return "redirect:/properties/list";
    }

    // 8. DELETE
    @GetMapping("/delete/{id}")
    public String deleteProperty(@PathVariable String id) {
        propertyService.deleteProperty(id);
        return "redirect:/properties/list";
    }

    // Helper - resolve agent names for FK
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