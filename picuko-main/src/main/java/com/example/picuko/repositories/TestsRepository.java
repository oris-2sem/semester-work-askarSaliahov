package com.example.picuko.repositories;

import com.example.picuko.entities.Test;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TestsRepository extends JpaRepository<Test, Long> {
}
