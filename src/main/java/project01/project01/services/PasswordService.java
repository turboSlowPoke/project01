package project01.project01.services;

import org.springframework.stereotype.Service;

@Service
public class PasswordService {
    public Boolean checkPassword(String password){
        return password.matches("/^[A-Za-z0-9\\d=!\\-@._*]+$/");
    }
}

