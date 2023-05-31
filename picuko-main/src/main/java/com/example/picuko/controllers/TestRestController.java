package com.example.picuko.controllers;

import com.example.picuko.entities.*;
import com.example.picuko.repositories.ScoreRepository;
import com.example.picuko.services.QuestionService;
import com.example.picuko.services.ScoreService;
import com.example.picuko.services.TestsService;
import com.example.picuko.services.TopicService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/tests")
public class TestRestController {

    public record CreateTestRequest(String topic, String name, String description, String questionName,
                                    String a, String b, String c, String d, String rightAnswer) {}
    public record UpdateTestRequest(String questionName, String a, String b, String c, String d, String rightAnswer) {}
    public record TestResponse(Long testId) {}
    public record CheckResultsResponse(Integer result) {}
    private final TopicService topicService;
    private final TestsService testsService;
    private final QuestionService questionService;
    private final ScoreService scoreService;
    private final ScoreRepository scoreRepository;


    @PostMapping("/create")
    @Transactional
    public ResponseEntity<?> createTest(@RequestBody CreateTestRequest request, Authentication authentication) {
        Account account = (Account) authentication.getPrincipal();
        Long topicId = Long.parseLong(request.topic);
        Topic topic = topicService.findById(topicId);

        Test test = Test.builder()
                .name(request.name)
                .description(request.description)
                .author(account)
                .topic(topic)
                .questions(new ArrayList<>())
                .build();

        Test savedTest = testsService.saveTest(test);

        Question question = Question.builder()
                .text(request.questionName)
                .test(savedTest)
                .rightAnswer(resolveAnswer(request.rightAnswer))
                .answers(List.of(request.a, request.b, request.c, request.d))
                .build();

        question = questionService.save(question);

        test.getQuestions().add(question);

        return ResponseEntity.ok(new TestResponse(savedTest.getId()));
    }

    @PatchMapping("/{id}")
    @Transactional
    public ResponseEntity<?> patchTest(@PathVariable Long id, @RequestBody UpdateTestRequest request) {
        Test test = testsService.findById(id);

        Question question = Question.builder()
                .test(test)
                .text(request.questionName)
                .answers(List.of(request.a, request.b, request.c, request.d))
                .rightAnswer(resolveAnswer(request.rightAnswer))
                .build();

        questionService.save(question);

        return ResponseEntity.ok().build();
    }

    @PostMapping("/{id}")
    @Transactional
    public ResponseEntity<?> checkResults(@PathVariable Long id,
                                          @RequestBody List<Integer> answers,
                                          @AuthenticationPrincipal Account account) {

        Test test = testsService.findById(id);
        List<Question> questions = test.getQuestions();
        Score userScore = account.getScore();
        Integer score = 0;

        if (answers.size() != questions.size()) {
            throw new IllegalArgumentException("Тi чмо");
        }

        for (int i = 0; i < answers.size(); i++) {
            if (questions.get(i).getRightAnswer().ordinal() == answers.get(i)) {
                score ++;
            }
        }


        if (userScore == null) {
           userScore = scoreService.save(
                    Score.builder()
                        .account(account)
                        .score(score)
                        .build()
            );

           account.setScore(userScore);

        } else {
            if (userScore.getScore() < score) {
                scoreRepository.updateScore(score, userScore.getId());
            }
        }

        return ResponseEntity.ok(new CheckResultsResponse(score));
    }

    private Question.Answer resolveAnswer(String answer) {
        return switch (answer) {
            case "a" -> Question.Answer.A;
            case "b" -> Question.Answer.B;
            case "c" -> Question.Answer.C;
            case "d" -> Question.Answer.D;
            default -> null;
        };
    }
}
