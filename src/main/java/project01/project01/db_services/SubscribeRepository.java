package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.Subscribe;

import java.time.LocalDate;

@Repository
public interface SubscribeRepository extends CrudRepository<Subscribe,Integer> {
    Long countAllByEndOfSignalAfter(LocalDate date);
    Long countAllByTrainingIsActiveTrue();
}
