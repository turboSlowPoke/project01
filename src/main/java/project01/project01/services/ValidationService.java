package project01.project01.services;

import org.springframework.stereotype.Service;

@Service
public class ValidationService {

    public Boolean checkPassword(String password){
        Boolean check=false;
        if (password!=null&&!password.isEmpty()) {
            check=true;
        }
        return check;
    }
}

