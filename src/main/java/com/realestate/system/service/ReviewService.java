package com.realestate.system.service;

import com.realestate.system.model.Review;
import com.realestate.system.util.FileManager;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReviewService {

    private List<Review> reviews = new ArrayList<>();

    @Autowired
    private AgentService agentService;

    @PostConstruct
    public void init() {
        loadFromFile();
        // Recalculate all agent ratings on startup (keeps data consistent)
        recalculateAllAgentRatings();
    }

    public void loadFromFile() {
        reviews.clear();
        List<String> lines = FileManager.readFile("reviews.txt");
        for (String line : lines) {
            reviews.add(Review.fromFileLine(line));
        }
    }

    public void saveToFile() {
        List<String> lines = new ArrayList<>();
        for (Review r : reviews) {
            lines.add(r.toFileLine());
        }
        FileManager.writeFile("reviews.txt", lines);
    }

    // CREATE - then update agent rating
    public boolean addReview(Review review) {
        if (searchById(review.getId()) != null) {
            return false; // duplicate ID
        }
        reviews.add(review);
        saveToFile();
        recalculateAgentRating(review.getAgentId()); // ⭐ INTEGRATION
        return true;
    }

    // READ - all
    public List<Review> getAllReviews() {
        return reviews;
    }

    // READ - by ID
    public Review searchById(String id) {
        for (Review r : reviews) {
            if (r.getId().equals(id)) return r;
        }
        return null;
    }

    // READ - by Agent
    public List<Review> getByAgentId(String agentId) {
        List<Review> result = new ArrayList<>();
        for (Review r : reviews) {
            if (r.getAgentId().equals(agentId)) result.add(r);
        }
        return result;
    }

    // READ - by Client
    public List<Review> getByClientId(String clientId) {
        List<Review> result = new ArrayList<>();
        for (Review r : reviews) {
            if (r.getClientId().equals(clientId)) result.add(r);
        }
        return result;
    }

    // UPDATE - then update agent rating
    public boolean updateReview(Review updated) {
        Review existing = searchById(updated.getId());
        if (existing == null) return false;

        String oldAgentId = existing.getAgentId();

        existing.setClientId(updated.getClientId());
        existing.setAgentId(updated.getAgentId());
        existing.setRating(updated.getRating());
        existing.setComment(updated.getComment());
        existing.setModerationStatus(updated.getModerationStatus());
        // reviewDate does not change

        saveToFile();

        // If agent changed, recalculate both
        recalculateAgentRating(oldAgentId);
        if (!oldAgentId.equals(updated.getAgentId())) {
            recalculateAgentRating(updated.getAgentId());
        }
        return true;
    }

    // DELETE - then update agent rating
    public boolean deleteReview(String id) {
        Review existing = searchById(id);
        if (existing == null) return false;
        String agentId = existing.getAgentId();
        reviews.remove(existing);
        saveToFile();
        recalculateAgentRating(agentId); // ⭐ INTEGRATION
        return true;
    }

    // ⭐ INTEGRATION: Recalculate one agent's average and push to agents.txt
    public void recalculateAgentRating(String agentId) {
        List<Review> agentReviews = getByAgentId(agentId);

        // Only count approved reviews (optional — remove this filter if you want all)
        List<Review> approved = new ArrayList<>();
        for (Review r : agentReviews) {
            if (!r.getModerationStatus().equals("Rejected")) {
                approved.add(r);
            }
        }

        if (approved.isEmpty()) {
            agentService.updateAgentRating(agentId, 0.0, 0);
            return;
        }

        double sum = 0;
        for (Review r : approved) {
            sum += r.getRating();
        }
        double avg = sum / approved.size();

        // Round to 1 decimal
        avg = Math.round(avg * 10.0) / 10.0;

        agentService.updateAgentRating(agentId, avg, approved.size());
    }

    // Recalculate all on startup
    private void recalculateAllAgentRatings() {
        List<String> agentIds = new ArrayList<>();
        for (Review r : reviews) {
            if (!agentIds.contains(r.getAgentId())) {
                agentIds.add(r.getAgentId());
            }
        }
        for (String agentId : agentIds) {
            recalculateAgentRating(agentId);
        }
    }
}