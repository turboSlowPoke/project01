package project01.project01.webcontrollers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.db_services.SubscribeRepository;
import project01.project01.db_services.UserRepository;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AdminPage {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private SubscribeRepository subscribeRepository;

    @GetMapping("/admin")
    public ModelAndView adminPageGet(){
        Map<String,Object> model = new HashMap<>();
        model.put("countUsers",userRepository.count());
        model.put("countActiveSubscribe",subscribeRepository.countAllByEndOfSignalAfter(LocalDate.now()));
        model.put("countUsersWithTraining",subscribeRepository.countAllByTrainingIsActiveTrue());
        return new ModelAndView("admin",model);

    }

    @PostMapping("/admin")
    public ModelAndView adminPagePost(){

    }
}
