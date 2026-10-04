package com.realestate.system.util;

import com.realestate.system.model.Agent;
import java.util.ArrayList;
import java.util.List;

public class AgentBST {
    private AgentBSTNode root;

    public AgentBST() {
        this.root = null;
    }

    // INSERT - Add agent to BST
    public void insert(Agent agent) {
        root = insertRec(root, agent);
    }

    private AgentBSTNode insertRec(AgentBSTNode node, Agent agent) {
        if (node == null) return new AgentBSTNode(agent);

        if (agent.getId().compareTo(node.agent.getId()) < 0) {
            node.left = insertRec(node.left, agent);
        } else if (agent.getId().compareTo(node.agent.getId()) > 0) {
            node.right = insertRec(node.right, agent);
        }
        return node;
    }

    // SEARCH - Find agent by ID
    public Agent search(String id) {
        return searchRec(root, id);
    }

    private Agent searchRec(AgentBSTNode node, String id) {
        if (node == null) return null;
        if (id.equals(node.agent.getId())) return node.agent;
        if (id.compareTo(node.agent.getId()) < 0) return searchRec(node.left, id);
        return searchRec(node.right, id);
    }

    // DELETE - Remove agent by ID
    public void delete(String id) {
        root = deleteRec(root, id);
    }

    private AgentBSTNode deleteRec(AgentBSTNode node, String id) {
        if (node == null) return null;

        if (id.compareTo(node.agent.getId()) < 0) {
            node.left = deleteRec(node.left, id);
        } else if (id.compareTo(node.agent.getId()) > 0) {
            node.right = deleteRec(node.right, id);
        } else {
            // Node with one or no child
            if (node.left == null) return node.right;
            if (node.right == null) return node.left;

            // Node with two children - get inorder successor
            node.agent = minValue(node.right);
            node.right = deleteRec(node.right, node.agent.getId());
        }
        return node;
    }

    private Agent minValue(AgentBSTNode node) {
        Agent min = node.agent;
        while (node.left != null) {
            min = node.left.agent;
            node = node.left;
        }
        return min;
    }

    // GET ALL agents (in-order traversal returns sorted by ID)
    public List<Agent> getAllAgents() {
        List<Agent> agents = new ArrayList<>();
        inorderRec(root, agents);
        return agents;
    }

    private void inorderRec(AgentBSTNode node, List<Agent> agents) {
        if (node != null) {
            inorderRec(node.left, agents);
            agents.add(node.agent);
            inorderRec(node.right, agents);
        }
    }

    // LOAD from agents.txt
    public void loadFromFile() {
        List<String> lines = FileManager.readFile("agents.txt");
        for (String line : lines) {
            insert(Agent.fromFileLine(line));
        }
    }

    // SAVE to agents.txt
    public void saveToFile() {
        List<Agent> agents = getAllAgents();
        List<String> lines = new ArrayList<>();
        for (Agent a : agents) {
            lines.add(a.toFileLine());
        }
        FileManager.writeFile("agents.txt", lines);
    }
}