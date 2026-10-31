package com.realestate.system.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileManager {

    private static final String DATA_PATH = "data/";

    public static List<String> readFile(String fileName) {
        List<String> lines = new ArrayList<>();
        File file = new File(DATA_PATH + fileName);
        if (!file.exists()) return lines;

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            // Throw exception so the GlobalExceptionHandler catches it
            throw new RuntimeException("Failed to read data from file: " + fileName, e);
        }
        return lines;
    }

    public static void writeFile(String fileName, List<String> lines) {
        File file = new File(DATA_PATH + fileName);
        file.getParentFile().mkdirs();

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file))) {
            for (String line : lines) {
                bw.write(line);
                bw.newLine();
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to write data to file: " + fileName, e);
        }
    }

    public static void appendLine(String fileName, String line) {
        File file = new File(DATA_PATH + fileName);
        file.getParentFile().mkdirs();

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file, true))) {
            bw.write(line);
            bw.newLine();
        } catch (IOException e) {
            throw new RuntimeException("Failed to append data to file: " + fileName, e);
        }
    }
}