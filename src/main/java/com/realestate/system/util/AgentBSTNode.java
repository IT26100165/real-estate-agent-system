package com.realestate.system.util;

import com.realestate.system.model.Agent;

public class AgentBSTNode {
    public Agent agent;
    public AgentBSTNode left, right;

    public AgentBSTNode(Agent agent) {
        this.agent = agent;
        this.left = null;
        this.right = null;
    }
}