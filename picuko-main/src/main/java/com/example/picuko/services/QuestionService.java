package com.example.picuko.services;

import com.example.picuko.entities.Question;
import com.example.picuko.repositories.QuestionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class QuestionService {
    private final QuestionRepository questionRepository;

    public Question save(Question question) {
        return questionRepository.save(question);
    }
}
