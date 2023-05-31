package com.example.picuko.controllers;

import com.example.picuko.services.AccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AccountService accountService;

    @GetMapping("/login")
    public String login() {
        return "login-page";
    }

    @GetMapping("/signup")
    public String signup() {
        return "registration-page";
    }

    @PostMapping("/signup")
    public String postSignup(@RequestParam String username, @RequestParam String password) {
        accountService.registerUser(username, password);

        return "redirect:/auth/login";
    }

}
