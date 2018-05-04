package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import project01.project01.entyties.Training;
import project01.project01.entyties.TrainingGroup;

import java.time.LocalDate;
import java.util.List;

public interface TrainingGroupRepository extends CrudRepository<TrainingGroup,Integer> {
    List<TrainingGroup> findTrainingGroupsByEndSetIsAfter (LocalDate date);
    List<TrainingGroup> findTrainingGroupsById(Integer id);
}
