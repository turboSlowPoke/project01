package project01.project01.db_services;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.Order;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Stream;

@Repository
public interface OrderRepository extends CrudRepository<Order,Integer> {
    @Query("SELECT SUM(o.amount) FROM Order o JOIN o.user u WHERE u.id=:id AND o.isPaid=true")
    BigDecimal amountReferalPayment(@Param("id") Integer id);
}
