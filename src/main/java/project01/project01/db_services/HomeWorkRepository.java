package project01.project01.db_services;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.Homework;

import java.util.List;

@Repository
public interface HomeWorkRepository extends CrudRepository<Homework,Integer> {
    @Query("SELECT h FROM Homework h JOIN h.user u WHERE u.id=:id")
    List<Homework> findAllByUser(@Param("id") Integer id);
    List<Homework> findAllByCheked(Boolean isCheked);
    List<Homework> findAllByChekedFalse();
}
