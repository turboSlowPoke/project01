package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import project01.project01.entyties.Training;

import java.util.List;

public interface TrainingRepository extends CrudRepository<Training,Integer> {
    List<Training> findTrainingByActive(Boolean active);
}
