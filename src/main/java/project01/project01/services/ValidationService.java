package project01.project01.services;

import org.springframework.stereotype.Service;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.User;

import java.util.Optional;

@Service
public class ValidationService {
    private UserRepository userRepository;

    public Boolean checkPassword(String password){
        Boolean check=false;
        if (password!=null
                &&password.length()>7
                &&password.length()<100) {
            check=true;
        }
        return check;
    }

    public Boolean checkLogin(String login){
        Boolean check=false;
        if (login!=null
                &&login.length()>3
                &&login.length()<100){
            check=true;
        }
        return check;
    }
}

