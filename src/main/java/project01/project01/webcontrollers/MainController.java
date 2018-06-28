package project01.project01.webcontrollers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.db_services.TrainingGroupRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.*;
import project01.project01.enums.Global;
import project01.project01.enums.Purchase;
import project01.project01.telegram.WebhookController;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Controller
public class MainController {
    private static final Logger log = LoggerFactory.getLogger(WebhookController.class);
    private final UserRepository userRepository;
    @Autowired
    private TrainingGroupRepository trainingGroupRepository;
    public MainController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/")
    public ModelAndView index(HttpServletRequest request,
                              @RequestParam(required = false, name = "uh") String userHash,
                              @RequestParam(required = false, name = "ref") String invitedId){
        HttpSession session = request.getSession();
        Map<String, String> model = new HashMap<>();
        if (userHash!=null){
            session.setAttribute("userHashFromTelegramLink",userHash);
            model.put("loginModalIsActive","active");
        }
        if (invitedId!=null)
            session.setAttribute("invitedId",invitedId);
        return new ModelAndView("/index", model);
    }

    @GetMapping("/faq")
    public ModelAndView getFaq(){
        Map<String,Object> model = new HashMap<>();
        return new ModelAndView("faq",model);

    }
    @GetMapping("/about")
    public ModelAndView getAbout(){
        Map<String,Object> model = new HashMap<>();
        return new ModelAndView("about",model);

    }
    @GetMapping("/contacts")
    public ModelAndView getContacts(){
        Map<String,Object> model = new HashMap<>();
        return new ModelAndView("contacts",model);

    }

    @GetMapping(value = "/pay")
    public ModelAndView sendRedirectToAdvcashPage(@RequestParam(value = "userId")String userId,
                                                  @RequestParam(value = "service") String service){
        Map<String, Object> model = new HashMap<>();
        try {
            model.put("user",userRepository.findUserById(Integer.parseInt(userId)).get(0));
        }catch (Exception e){
            model.put("user",null);
        }
        Purchase paidServices = Purchase.getTYPE(service);
        String purchase=null;
        if (paidServices!=Purchase.FAIL) {
//            switch (paidServices){
//                case SIGNALS01:
//                    purchase=Global.SIGNALS01.getText();
//                    break;
//                case SIGNALS02:
//                    purchase=Global.SIGNALS02.getText();
//                    break;
//                case SIGNALS03:
//                    purchase=Global.SIGNALS03.getText();
//                    break;
//                case TRAINING:
//                    purchase=Global.TRAINING.getText();
//                    break;
//                case TRAINING02:
//                    purchase=Global.TRAINING02.getText();
//                    break;
//                case TRAINING03:
//                    purchase=Global.TRAINING03.getText();
//                    break;
//                default:
//                    purchase="fail";
//
//            }
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
        User user = new User("admin");
        userRepository.save(user);
        user.setStartDate(LocalDateTime.now());
        String checkString = user.getId().toString()+user.getStartDate()+Global.COD_WORD.getText();
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        md.update(checkString.getBytes(StandardCharsets.UTF_8));
        byte[] digest = md.digest();
        String hash = String.format("%064x", new BigInteger( 1, digest ) );
        user.setHash(hash);
        UserData userData = new UserData();
        userData.setFirstName("суперимя");
        userData.setLastName("суперфамилия");
        user.setUserData(userData);
        String password = new BCryptPasswordEncoder().encode("MegaAdmin");
        user.setPassword(password);
        Set<Role> roles = new HashSet<>();
        roles.add(new Role("ADMIN"));
        user.setRoles(roles);
        Subscribe subscribe = new Subscribe();
        subscribe.setEndOfSignal(LocalDate.now().plusMonths(1));
        user.setSubsribe(subscribe);
        userRepository.save(user);
        System.out.println("юзер " +user +" добавлен");
    }

}
