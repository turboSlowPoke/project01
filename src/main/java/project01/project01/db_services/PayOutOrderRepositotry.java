package project01.project01.db_services;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import project01.project01.entyties.PayOutOrder;

import java.util.List;

public interface PayOutOrderRepositotry extends CrudRepository<PayOutOrder,Integer> {
    @Query("SELECT p FROM PayOutOrder p JOIN p.user u WHERE u.id=:userId AND p.close=false")
    List<PayOutOrder> findOpenOrder(@Param("userId") Integer userId);
}
