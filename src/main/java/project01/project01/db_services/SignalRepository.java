package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import project01.project01.entyties.Signal;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface SignalRepository extends CrudRepository<Signal, Integer> {
    List<Signal> findSignalByDateTimeAfter(LocalDateTime dateTime);
}
