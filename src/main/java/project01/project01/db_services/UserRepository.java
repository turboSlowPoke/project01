package project01.project01.db_services;

import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.Order;
import project01.project01.entyties.User;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

@Repository
public interface UserRepository extends CrudRepository<User,Integer> {
    List<User> findUserById(Integer id);
    Optional<User> findUserByLogin(String login);
    List<User> findUserByTelegramChatId(Integer id);
    List<User> findUserByGoogleId(String googleAuthId);
    List<User> findUserByHash(String hash);
    @Query("SELECT  u FROM User u JOIN u.subsribe s WHERE s.endOfSignal>:date")
    List<User> findUserForSendSignals(@Param("date") LocalDate date);
    long countByInvitedId(Integer invitedId);

}
