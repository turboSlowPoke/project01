package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.User;

import java.util.List;
@Repository
public interface UserRepository extends CrudRepository<User,Integer> {
    List<User> findUserById(Integer id);
    List<User> findUserByLogin(String login);
    List<User> findUserByTelegramChatId(Integer id);
}
