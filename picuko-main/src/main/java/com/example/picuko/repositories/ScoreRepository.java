package com.example.picuko.repositories;

import com.example.picuko.entities.Score;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ScoreRepository extends JpaRepository<Score, Long> {
    @Modifying
    @Query("update Score sc set sc.score = :score where sc.id = :id")
    int updateScore(@Param("score") Integer score, @Param("id") Long id);

}
