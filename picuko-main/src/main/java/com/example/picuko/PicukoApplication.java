package com.example.picuko;

import com.example.picuko.entities.Account;
import com.example.picuko.entities.Score;
import com.example.picuko.repositories.AccountRepository;
import com.example.picuko.services.AccountService;
import com.example.picuko.services.ScoreService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class PicukoApplication {


//    @Bean
    public CommandLineRunner commandLineRunner(ScoreService scoreService, AccountRepository accountRepository) {
        Account account = accountRepository.findById(1L).get();
        Score score = Score.builder()
                .score(12)
                .build();
        score = scoreService.save(score);

        account.setScore(score);
        return args -> {};
    }

    public static void main(String[] args) {
        SpringApplication.run(PicukoApplication.class, args);
    }

}
