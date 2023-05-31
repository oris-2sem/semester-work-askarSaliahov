package com.example.picuko.services;

import com.example.picuko.entities.Score;
import com.example.picuko.repositories.ScoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ScoreService {
    private final ScoreRepository scoreRepository;

    public Score save(Score score) {
       return scoreRepository.save(score);
    }
}
