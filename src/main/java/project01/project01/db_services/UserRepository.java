package project01.project01.db_services;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.Role;
import project01.project01.entyties.User;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User,Integer> {
    List<User> findUserById(Integer id);
    Optional<User> findUserByLogin(String login);
    List<User> findUserByTelegramChatId(Integer id);
    List<User> findUserByGoogleId(String googleAuthId);
    List<User> findUserByHash(String hash);
    @Query("SELECT  u FROM User u JOIN u.subsribe s WHERE s.endOfSignal>:dateTime")
    List<User> findUserForSendSignals(LocalDateTime dateTime);
}
