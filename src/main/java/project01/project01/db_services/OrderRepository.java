package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import project01.project01.entyties.Order;

public interface OrderRepository extends CrudRepository<Order,Integer> {
}
