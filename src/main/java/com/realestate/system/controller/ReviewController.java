package com.realestate.system.controller;

import com.realestate.system.model.Agent;
import com.realestate.system.model.Client;
import com.realestate.system.model.Review;
import com.realestate.system.service.AgentService;
import com.realestate.system.service.ClientService;
import com.realestate.system.service.ReviewService;
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

    // 1. LIST
    @GetMapping("/list")
    public String listReviews(Model model) {
        List<Review> reviews = reviewService.getAllReviews();
        model.addAttribute("reviews", reviews);
        model.addAttribute("clientNames", buildClientNameMap(reviews));
        model.addAttribute("agentNames", buildAgentNameMap(reviews));
        return "review-list";
    }

    // 2. ADD PAGE
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "review-add";
    }

    // 3. ADD - process
    @PostMapping("/add")
    public String addReview(@RequestParam String id,
                            @RequestParam String clientId,
                            @RequestParam String agentId,
                            @RequestParam int rating,
                            @RequestParam String comment,
                            @RequestParam String moderationStatus,
                            Model model) {
        String today = LocalDate.now().toString();
        Review review = new Review(id, clientId, agentId, rating,
                comment, today, moderationStatus);

        boolean success = reviewService.addReview(review);
        if (!success) {
            model.addAttribute("error", "Duplicate Review ID detected.");
            model.addAttribute("clients", clientService.getAllClients());
            model.addAttribute("agents", agentService.getAllAgents());
            return "review-add";
        }
        return "redirect:/reviews/list";
    }

    // 4. SEARCH PAGE
    @GetMapping("/search")
    public String showSearchForm() {
        return "review-search";
    }

    // 5. SEARCH - results
    @GetMapping("/search/results")
    public String searchReview(@RequestParam String id, Model model) {
        Review review = reviewService.searchById(id);
        model.addAttribute("review", review);
        model.addAttribute("searchedId", id);

        if (review != null) {
            Client client = clientService.searchById(review.getClientId());
            Agent agent = agentService.searchById(review.getAgentId());
            model.addAttribute("clientName", client != null ? client.getName() : "Unknown");
            model.addAttribute("agentName", agent != null ? agent.getName() : "Unknown");
        }
        return "review-search";
    }

    // 6. EDIT PAGE
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Review review = reviewService.searchById(id);
        if (review == null) {
            return "redirect:/reviews/list";
        }
        model.addAttribute("review", review);
        model.addAttribute("clients", clientService.getAllClients());
        model.addAttribute("agents", agentService.getAllAgents());
        return "review-edit";
    }

    // 7. EDIT - process
    @PostMapping("/edit")
    public String updateReview(@RequestParam String id,
                               @RequestParam String clientId,
                               @RequestParam String agentId,
                               @RequestParam int rating,
                               @RequestParam String comment,
                               @RequestParam String reviewDate,
                               @RequestParam String moderationStatus) {
        Review review = new Review(id, clientId, agentId, rating,
                comment, reviewDate, moderationStatus);
        reviewService.updateReview(review);
        return "redirect:/reviews/list";
    }

    // 8. DELETE
    @GetMapping("/delete/{id}")
    public String deleteReview(@PathVariable String id) {
        reviewService.deleteReview(id);
        return "redirect:/reviews/list";
    }

    // ===== FK Resolution Helpers =====
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