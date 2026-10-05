package com.realestate.system.service;

import com.realestate.system.model.Agent;
import com.realestate.system.util.AgentBST;
import com.realestate.system.util.SelectionSort;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.util.List;

@Service
public class AgentService {

    private AgentBST agentBST = new AgentBST();

    @PostConstruct
    public void init() {
        agentBST.loadFromFile();
    }

    public void addAgent(Agent agent) {
        agentBST.insert(agent);
        agentBST.saveToFile();
    }

    public List<Agent> getAllAgentsSortedByRating() {
        List<Agent> agents = agentBST.getAllAgents();
        SelectionSort.sortByRating(agents);
        return agents;
    }

    public List<Agent> getAllAgents() {
        return agentBST.getAllAgents();
    }

    public Agent searchById(String id) {
        return agentBST.search(id);
    }

    // UPDATE
    public boolean updateAgent(Agent updatedAgent) {
        Agent existing = agentBST.search(updatedAgent.getId());
        if (existing == null) return false;

        // Update the existing object's fields (keeps BST structure intact)
        existing.setName(updatedAgent.getName());
        existing.setEmail(updatedAgent.getEmail());
        existing.setPassword(updatedAgent.getPassword());
        existing.setSpecialization(updatedAgent.getSpecialization());
        existing.setContactNumber(updatedAgent.getContactNumber());

        agentBST.saveToFile();
        return true;
    }

    // AUTHENTICATE - Check email + password against agents
    public Agent authenticate(String email, String password) {
        List<Agent> agents = agentBST.getAllAgents();
        for (Agent a : agents) {
            if (a.getEmail().equals(email) && a.getPassword().equals(password)) {
                return a;
            }
        }
        return null;
    }

    public boolean deleteAgent(String id) {
        Agent existing = agentBST.search(id);
        if (existing == null) return false;
        agentBST.delete(id);
        agentBST.saveToFile();
        return true;
    }
}