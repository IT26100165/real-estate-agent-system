package com.realestate.system.controller;

import com.realestate.system.model.Client;
import com.realestate.system.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/clients")
public class ClientController {

    @Autowired
    private ClientService clientService;

    // 1. LIST
    @GetMapping("/list")
    public String listClients(Model model) {
        model.addAttribute("clients", clientService.getAllClients());
        return "client-list";
    }

    // 2. ADD PAGE
    @GetMapping("/add")
    public String showAddForm() {
        return "client-add";
    }

    // 3. ADD - process form
    @PostMapping("/add")
    public String addClient(@RequestParam String id,
                            @RequestParam String name,
                            @RequestParam String email,
                            @RequestParam String password,
                            @RequestParam String phoneNumber,
                            @RequestParam String address,
                            @RequestParam String propertyPreference) {
        String today = LocalDate.now().toString();
        Client client = new Client(id, name, email, password,
                phoneNumber, address, propertyPreference, today);
        clientService.addClient(client);
        return "redirect:/clients/list";
    }

    // 4. SEARCH PAGE
    @GetMapping("/search")
    public String showSearchForm() {
        return "client-search";
    }

    // 5. SEARCH - process
    @GetMapping("/search/results")
    public String searchClient(@RequestParam String id, Model model) {
        Client client = clientService.searchById(id);
        model.addAttribute("client", client);
        model.addAttribute("searchedId", id);
        return "client-search";
    }

    // 6. EDIT PAGE
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Client client = clientService.searchById(id);
        if (client == null) {
            return "redirect:/clients/list";
        }
        model.addAttribute("client", client);
        return "client-edit";
    }

    // 7. EDIT - process form
    @PostMapping("/edit")
    public String updateClient(@RequestParam String id,
                               @RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String phoneNumber,
                               @RequestParam String address,
                               @RequestParam String propertyPreference,
                               @RequestParam String registrationDate) {
        Client client = new Client(id, name, email, password,
                phoneNumber, address, propertyPreference, registrationDate);
        clientService.updateClient(client);
        return "redirect:/clients/list";
    }

    // 8. DELETE
    @GetMapping("/delete/{id}")
    public String deleteClient(@PathVariable String id) {
        clientService.deleteClient(id);
        return "redirect:/clients/list";
    }
}