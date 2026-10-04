package com.realestate.system;

import com.realestate.system.model.Agent;
import com.realestate.system.util.AgentBST;
import com.realestate.system.util.SelectionSort;
import java.util.List;

public class TestAgentModule {
    public static void main(String[] args) {
        System.out.println("=== AGENT MODULE TEST ===\n");

        // Create test agents
        Agent a1 = new Agent("AG-1003", "John Silva", "john@test.com", "pass123",
                "Residential", "077-1111111");
        a1.setAverageRating(4.2);
        a1.setTotalReviews(15);

        Agent a2 = new Agent("AG-1001", "Sarah Perera", "sarah@test.com", "pass123",
                "Commercial", "077-2222222");
        a2.setAverageRating(4.8);
        a2.setTotalReviews(22);

        Agent a3 = new Agent("AG-1002", "Mike Fernando", "mike@test.com", "pass123",
                "Land", "077-3333333");
        a3.setAverageRating(3.9);
        a3.setTotalReviews(8);

        Agent a4 = new Agent("AG-1004", "Nimal Jayasuriya", "nimal@test.com", "pass123",
                "Residential", "077-4444444");
        a4.setAverageRating(4.5);
        a4.setTotalReviews(18);

        // TEST 1: INSERT into BST
        System.out.println("TEST 1: Inserting agents into BST...");
        AgentBST bst = new AgentBST();
        bst.insert(a1);
        bst.insert(a2);
        bst.insert(a3);
        bst.insert(a4);
        System.out.println("✅ Inserted 4 agents\n");

        // TEST 2: SAVE to file
        System.out.println("TEST 2: Saving to agents.txt...");
        bst.saveToFile();
        System.out.println("✅ Saved to data/agents.txt\n");

        // TEST 3: LOAD from file
        System.out.println("TEST 3: Loading from agents.txt...");
        AgentBST bst2 = new AgentBST();
        bst2.loadFromFile();
        List<Agent> loaded = bst2.getAllAgents();
        System.out.println("✅ Loaded " + loaded.size() + " agents\n");

        // TEST 4: Display all (in-order traversal by ID)
        System.out.println("TEST 4: All agents sorted by ID (BST in-order):");
        for (Agent a : loaded) {
            System.out.println("  " + a.getId() + " | " + a.getName()
                    + " | " + a.getSpecialization()
                    + " | Rating: " + a.getAverageRating());
        }
        System.out.println();

        // TEST 5: SEARCH
        System.out.println("TEST 5: Searching for AG-1002...");
        Agent found = bst2.search("AG-1002");
        if (found != null) {
            System.out.println("✅ Found: " + found.getName() + " (" + found.getSpecialization() + ")\n");
        } else {
            System.out.println("❌ Not found\n");
        }

        // TEST 6: SEARCH for non-existent
        System.out.println("TEST 6: Searching for AG-9999 (should be null)...");
        Agent notFound = bst2.search("AG-9999");
        System.out.println(notFound == null ? "✅ Correctly returned null\n" : "❌ Should be null\n");

        // TEST 7: SELECTION SORT by rating
        System.out.println("TEST 7: Sorting agents by rating (highest first)...");
        SelectionSort.sortByRating(loaded);
        for (Agent a : loaded) {
            System.out.println("  " + a.getName() + " - Rating: " + a.getAverageRating());
        }
        System.out.println();

        // TEST 8: DELETE
        System.out.println("TEST 8: Deleting AG-1002...");
        bst2.delete("AG-1002");
        Agent deleted = bst2.search("AG-1002");
        System.out.println(deleted == null ? "✅ Deleted successfully\n" : "❌ Delete failed\n");

        // TEST 9: Count after delete
        System.out.println("TEST 9: Agent count after delete: " + bst2.getAllAgents().size());

        System.out.println("\n=== ALL TESTS COMPLETE ===");
    }
}