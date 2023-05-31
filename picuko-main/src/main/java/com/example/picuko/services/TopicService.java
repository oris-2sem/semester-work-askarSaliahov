package com.example.picuko.services;

import com.example.picuko.entities.Topic;
import com.example.picuko.repositories.TopicRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TopicService {
    private final TopicRepository topicRepository;

    public List<Topic> getAllTopics() {
        return topicRepository.findAll();
    }
    public Topic findById(Long id) {
        return topicRepository.findById(id).orElseThrow();
    }
}
