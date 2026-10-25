package com.realestate.system.controller;

import com.realestate.system.model.Agent;
import com.realestate.system.model.Client;
import com.realestate.system.model.Review;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.ClientService;
import com.realestate.system.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reviews")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private AgentService agentService;

    @GetMapping("/list")
    public String listReviews(Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        List<Review> reviews = reviewService.getAllReviews();
        model.addAttribute("reviews", reviews);
        model.addAttribute("clientNames", buildClientNameMap(reviews));
        model.addAttribute("agentNames", buildAgentNameMap(reviews));
        return "review-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "review-add";
    }

    @PostMapping("/add")
    public String addReview(@RequestParam String id, @RequestParam String clientId, @RequestParam String agentId, @RequestParam int rating, @RequestParam String comment, @RequestParam String moderationStatus, Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        if (!reviewService.addReview(new Review(id, clientId, agentId, rating, comment, LocalDate.now().toString(), moderationStatus))) {
            model.addAttribute("error", "Duplicate ID.");
            model.addAttribute("clients", clientService.getAllClients());
            model.addAttribute("agents", agentService.getAllAgents());
            return "review-add";
        }
        return "redirect:/reviews/list";
    }

    @GetMapping("/search")
    public String showSearchForm(HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        return "review-search";
    }

    @GetMapping("/search/results")
    public String searchReview(@RequestParam String id, Model model, HttpSession session) {
        if (session.getAttribute("role") == null) return "redirect:/login";
        Review review = reviewService.searchById(id);
        model.addAttribute("review", review);
        model.addAttribute("searchedId", id);
        if (review != null) {
            model.addAttribute("clientName", clientService.searchById(review.getClientId()) != null ? clientService.searchById(review.getClientId()).getName() : "Unknown");
            model.addAttribute("agentName", agentService.searchById(review.getAgentId()) != null ? agentService.searchById(review.getAgentId()).getName() : "Unknown");
        }
        return "review-search";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/reviews/list";
        Review review = reviewService.searchById(id);
        if (review == null) return "redirect:/reviews/list";
        model.addAttribute("review", review);
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "review-edit";
    }

    @PostMapping("/edit")
    public String updateReview(@RequestParam String id, @RequestParam String clientId, @RequestParam String agentId, @RequestParam int rating, @RequestParam String comment, @RequestParam String reviewDate, @RequestParam String moderationStatus, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/reviews/list";
        reviewService.updateReview(new Review(id, clientId, agentId, rating, comment, reviewDate, moderationStatus));
        return "redirect:/reviews/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteReview(@PathVariable String id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/reviews/list";
        reviewService.deleteReview(id);
        return "redirect:/reviews/list";
    }

    private Map<String, String> buildClientNameMap(List<Review> reviews) {
        Map<String, String> map = new HashMap<>();
        for (Review r : reviews) {
            if (!map.containsKey(r.getClientId())) {
                Client c = clientService.searchById(r.getClientId());
                map.put(r.getClientId(), c != null ? c.getName() : "Unknown");
            }
        }
        return map;
    }
    private Map<String, String> buildAgentNameMap(List<Review> reviews) {
        Map<String, String> map = new HashMap<>();
        for (Review r : reviews) {
            if (!map.containsKey(r.getAgentId())) {
                Agent a = agentService.searchById(r.getAgentId());
                map.put(r.getAgentId(), a != null ? a.getName() : "Unknown");
            }
        }
        return map;
    }
}