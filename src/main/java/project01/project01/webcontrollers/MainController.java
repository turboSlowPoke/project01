package project01.project01.webcontrollers;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Role;
import project01.project01.entyties.User;
import project01.project01.entyties.UserData;
import project01.project01.enums.Global;
import project01.project01.enums.PaidServices;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class MainController {
    private final UserRepository userRepository;
    public MainController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/")
    public ModelAndView index(HttpServletRequest request){
        request.getSession().setAttribute("test","test");
        Map<String, String> model = new HashMap<>();
        return new ModelAndView("/index", model);
    }

    @GetMapping(value = "/pay")
    public ModelAndView sendRedirectToAdvcashPage(@RequestParam(value = "userId")String userId, @RequestParam(value = "service") String service){
        Map<String, Object> model = new HashMap<>();
        try {
            model.put("user",userRepository.findUserById(Integer.parseInt(userId)).get(0));
        }catch (Exception e){
            model.put("user",null);
        }
        PaidServices paidServices = PaidServices.getTYPE(service);
        String purchase;
        if (paidServices!=PaidServices.FAIL) {
            switch (paidServices){
                case SIGNALS01:
                    purchase=Global.SIGNALS01.getText();
                    break;
                case SIGNALS02:
                    purchase=Global.SIGNALS02.getText();
                    break;
                case SIGNALS03:
                    purchase=Global.SIGNALS03.getText();
                    break;
                case TRAINING01:
                    purchase=Global.TRAINING01.getText();
                    break;
                case TRAINING02:
                    purchase=Global.TRAINING02.getText();
                    break;
                case TRAINING03:
                    purchase=Global.TRAINING03.getText();
                    break;
                default:
                    purchase="fail";

            }
            model.put("service",purchase);
        }
        model.put("closeLink",Global.BOT_LINK.getText());
        return new ModelAndView("pay", model);
    }

    @GetMapping(value = "/login")
    public ModelAndView login(@RequestParam Optional<String> error){
        if (!error.isPresent())
            error=null;
        return new ModelAndView("login","error",error);
    }

    @PostConstruct
    public void addUser(){
        User user = new User("user01");
        UserData userData = new UserData();
        userData.setFirstName("суперимя");
        userData.setLastName("суперфамилия");
        user.setUserData(userData);
        String password = new BCryptPasswordEncoder().encode("123456");
        user.setPassword(password);
        Set<Role> roles = new HashSet<>();
        roles.add(new Role());
        user.setRoles(roles);
        userRepository.save(user);
        System.out.println("юзер " +user +" добавлен");
    }

}
