package com.example.picuko.controllers;

import com.example.picuko.entities.Account;
import com.example.picuko.entities.Test;
import com.example.picuko.services.TestsService;
import com.example.picuko.services.TopicService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/tests")
@RequiredArgsConstructor
public class TestController {

    private final TopicService topicService;
    private final TestsService testsService;

    @GetMapping
    public String tests(Model model) {
        model.addAttribute("tests", testsService.findAll());
        return "tests";
    }

    @GetMapping("/{id}")
    public String test(@PathVariable Long id, Model model) {

        Test test = testsService.findById(id);
        model.addAttribute("test", test);

        return "test";
    }

    @GetMapping("/create")
    public String createTest(Model model) {

        model.addAttribute("topics", topicService.getAllTopics());

        return "create-test";
    }


}

// TODO: сделать прохождение теста с последовательным появлением вопросов через rest