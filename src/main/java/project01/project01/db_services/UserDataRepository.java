package project01.project01.db_services;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import project01.project01.entyties.UserData;

@Repository
public interface UserDataRepository extends CrudRepository<UserData,Integer> {
}
