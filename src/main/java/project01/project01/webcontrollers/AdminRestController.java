package project01.project01.webcontrollers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.User;

import javax.transaction.Transactional;
import java.util.Optional;

@RestController
public class AdminRestController {
    private static final Logger log = LoggerFactory.getLogger(AdminRestController.class);
    private UserRepository userRepository;
    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Transactional
    @GetMapping("/admin/search_user")
    public @ResponseBody User searchUser(@RequestParam("parameter_type") String parameterType,
                                         @RequestParam("parameter_data") String parameterData){
        log.info("пришел запрос на поиск юзера");
        User user = null;
        Optional<User> optionalUser = userRepository.findById(Integer.parseInt(parameterData));
        if (optionalUser.isPresent())
            user=optionalUser.get();

        return user;
    }
}
