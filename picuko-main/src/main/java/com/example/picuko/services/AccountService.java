package com.example.picuko.services;

import com.example.picuko.entities.Account;
import com.example.picuko.repositories.AccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AccountService {
    private final AccountRepository accountRepository;
    private final PasswordEncoder passwordEncoder;
    public void registerUser(String username, String password) {
        accountRepository.save(Account
                .builder()
                .email(username)
                .password(passwordEncoder.encode(password))
                .role(Account.Role.ROLE_USER)
                .build());
    }
}
