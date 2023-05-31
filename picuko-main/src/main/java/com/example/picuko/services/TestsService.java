package com.example.picuko.services;

import com.example.picuko.entities.Test;
import com.example.picuko.repositories.TestsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TestsService {
    private final TestsRepository testsRepository;

    public Test saveTest(Test test) {
        return testsRepository.save(test);
    }
    public Test findById(Long id) {
        return testsRepository.findById(id).orElseThrow();
    }

    public List<Test> findAll() {
        return testsRepository.findAll();
    }
}
