package com.realestate.system.util;

import com.realestate.system.model.Agent;
import java.util.List;

public class SelectionSort {

    // Sort agents by averageRating (highest rating first)
    public static void sortByRating(List<Agent> agents) {
        int n = agents.size();

        for (int i = 0; i < n - 1; i++) {
            int maxIndex = i;

            for (int j = i + 1; j < n; j++) {
                if (agents.get(j).getAverageRating() > agents.get(maxIndex).getAverageRating()) {
                    maxIndex = j;
                }
            }

            // Swap
            Agent temp = agents.get(maxIndex);
            agents.set(maxIndex, agents.get(i));
            agents.set(i, temp);
        }
    }
}