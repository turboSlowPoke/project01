package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.Signal;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface SignalRepository extends CrudRepository<Signal, Integer> {
    List<Signal> findSignalByDateTimeAfter(LocalDateTime dateTime);
}
